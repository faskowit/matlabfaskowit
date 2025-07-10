function [h] = quick_trisurf(surfstruct, data) 

% surface_midthickness = 
% 
%   struct with fields:
% 
%     vertices: [32492×3 double]
%        faces: [64980×3 double]

faces = surfstruct.faces ; 
verts = surfstruct.vertices ; 

if nargin < 2
    data = 1:length(verts) ;
end
 
if size(faces,2) > size(faces,1) 
    faces = faces' ; 
end

if size(verts,2) > size(verts,1) 
    verts = verts' ; 
end
if size(verts,2) > size(verts,1) 
    verts = verts' ; 
end

h = trisurf(faces,verts(:,1),verts(:,2),verts(:,3),data) ; 
h.EdgeColor = 'none' ; 