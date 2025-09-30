classdef local_o_lib_cv
    % I named this with "cv" so that it distinguishes the file where the
    % time series AND covmatrix(cv) are passed through local_o_information
    methods(Static)

% ﻿MATLAB code for calculating local mutual information,
%  total correlation, dual total correlation, and O-Information.

% Calculates the probability density of a point pulled from a univariate Gaussian. 
% Arguments: 
%     x: A floating point value: the instantanious value of the z-scored timeseries.
%     mu: A floating point value: The mean of the distribution P(X).
%     sigma: A floating point value: the standard deviation of the distribution P(X)

% pd = probability density 
function pd = gaussian(x,mu,sigma)
    % pd = 1./(sigma * sqrt(2*pi)) .* exp(-0.5.*((x-mu)./sigma).^2);
    pd = normpdf(x) ; 
end

% The shannon information content of a single variable.
% Essentially just a -log() wrapper for the _gaussian() function.
% Takes all the same arguments.
   
function LE = local_entropy(x,mu,sigma)
    LE = -log(local_o_lib_cv.gaussian(x,mu,sigma));
end

% Calculates the probability of a 2-dimensional vector pulled from a bivariate Gaussian. 
% Arguments:
%     x: A 2-by-one array giving the joint state of our 2-dimensional system.
%     mu: A 2-by-one array, giving the mean of each dimension. 
%     sigma: A 2-by-one array giving the standard deviation of each dimension.
%     rho: The Pearson correlation between both dimensions. 

function pd2d = gaussian_2d(x,rho)
    norm = 1/(2*pi*sqrt(1-(rho^2)));
    exp_upper = (x(:,1).^2) - (2.*rho.*x(:,1).*x(:,2)) + (x(:,2).^2);
    exp_lower = 2 * (1-(rho^2));
    pd2d = norm .* exp(-1 *(exp_upper./exp_lower));
end

% The shannon information content of a single 2-dimensional variable.
% Essentially just a -log() wrapper for the _gaussian_2d() function. 

function LE2d = local_entropy_2d(x,mu,sigma,rho)
    LE2d = -log(local_o_lib_cv.gaussian_2d(x,mu,sigma,rho))
end

% Calculates the local mutual inforamtion a 2-dimensional vector pulled from a bivariate Gaussian.
% Arguments:
%     x: A 2-cell array giving the joint state of our 2-dimensional system.
%     mu: A 2-cell array, giving the mean of each dimension. 
%     sigma: A 2-cell array giving the standard deviation of each dimension.
%     rho: The Pearson correlation between both dimensions. 

function pmi = gaussian_pmi(vec,mu,sigma,rho)
    marg_x = local_o_lib_cv.gaussian(vec(1),mu(1),sigma(1));
    marg_y = local_o_lib_cv.gaussian(vec(2),mu(2),sigma(2));
    joint = local_o_lib_cv.gaussian_2d(vec,mu,sigma,rho);
    pmi = log(joint / (marg_x * marg_y));
end

% Given a 2-dimensional array (channels x time), returns the edge-timeseries array,
% Which has dimensions (((channels**2)-channels)/2, time)

function ets = local_edge_timeseries(X)
    N = floor(((size(X,1)^2) - size(X,1))/2);
    ets = zeros(N,size(X,2));
    counter = 1;
    vec = zeros(2,1);
    mu = zeros(2,1);
    sigma = zeros(2,1);
    
    for i = 1:size(X,1)
        mu(1,:) = mean(X(i,:));
        sigma(1,:) = std(X(i,:));
        
        for j=1:i-1
               
                mu(2,:) = mean(X(j,:));
                sigma(2,:) = std(X(j,:));
            
                rho = corr(X(i,:)',X(j,:)','type','Pearson');
            
                for k= 1:size(X,2)
                    vec(1) = X(i,k);
                    vec(2) = X(j,k);
                
                    ets(counter,k) = local_o_lib_cv.gaussian_pmi(vec,mu,sigma,rho);
                end
                counter = counter +1;
 
            
        end
    end
end

function joint_ents = local_gaussian_joint_entropy(X,cv) 
    % assuming dist. is gaussian
    N0 = size(X,1);
    N1 = size(X,2);
    
    mu = mean(X,2);
    sigma = std(X,0,2);
    
    %cv = reshape(cov(X',1),[size(X,1),size(X,1)]); %if something is off check this row because of degree of freedom thing
   % cov/corr same for gaussian 
   % I commented this out so that I can just use the cv that is already in
   % the function
    iv = inv(cv);
    
    dt = det(cv);
    
    norm = 1/sqrt(((2*pi)^(N0))*dt);
    
    err = zeros(1,N0); %what is this line doing here?
    joint_ents = zeros(1,N1);
    
    for i = 1:N1
        for j = 1:N0
            err(j)= X(j,i)-mu(j);
        end
        
        mul = -0.5 * (err*iv)*err';
        joint_ents(i) = -1*log(norm.* exp(mul));
    end
end

function LTC = local_total_correlation(X,cv)
    N0 = size(X,1);
    N1 = size(X,2);
    
    mu = mean(X,2);
    sigma = std(X,0,2);
    
    joint_ents = local_o_lib_cv.local_gaussian_joint_entropy(X,cv); % h 
    sum_marg_ents = zeros(1,N1);
    
    for i = 1:N1
        for j = 1:N0
            %where would cv be used here? 
            sum_marg_ents(i) = sum_marg_ents(i) + local_o_lib_cv.local_entropy(X(j,i),mu(j),sigma(j));
        end
    end
    
    LTC = sum_marg_ents - joint_ents;
end

function local_dtc = local_dual_total_correlation(X,cv) 
    N0 = size(X,1); % 1dim
    N1 = size(X,2);  %2dim
    
    joint_ents = local_o_lib_cv.local_gaussian_joint_entropy(X,cv);
    
    sum_resid_ents = zeros(1,N1);
    local_dtc = zeros(1,N1);

    %entropy of indiv nodes given that 
    for i = 1:N0
        ff = linspace(1,N0,N0); ff(ff==i)=[];
        X_resid = X(ff,:);
        cv1 = cv(ff,ff);
        joint_ents_resid = local_o_lib_cv.local_gaussian_joint_entropy(X_resid, cv1);
        
        for j = 1:N1
            sum_resid_ents(j) = sum_resid_ents(j) + joint_ents(j) - joint_ents_resid(j);
        end
    end
    
    for i = 1:N1
        local_dtc(i) = local_dtc(i) + joint_ents(i) - sum_resid_ents(i);
    end
end

function LO = local_o_information(X,cv)
    % goal: local_o_information(X,cv) 
    %this is just like the slides I had before! 
    LO = local_o_lib_cv.local_total_correlation(X,cv) - local_o_lib_cv.local_dual_total_correlation(X,cv);
end

%ignore this for now 
function LS = local_s_information(X)
    LS = local_o_lib_cv.local_total_correlation(X) + local_o_lib_cv.local_dual_total_correlation(X);
end

function gtc = gaussian_total_correlation(X)
    cor = corr(X','type','Pearson');    
    dt = det(cor);
    gtc = -log(dt)/2;
end

function g_mi = gaussian_mi(X,Y)
    % rho = corr(X(:),Y(:),'type','Pearson');
    % g_mi = -0.5*log(1-(rho^2));
    g_mi = -0.5*log(1-(corr(X(:),Y(:))^2)) ; 
end

    end
end


    
    
    


           




