function [tt] = get_middle_tickplaces(cb,num)

dTk = diff(cb.Limits)/(2*num) ; 
tt = cb.Limits(1)+dTk:2*dTk:cb.Limits(2)-dTk ; 
set(cb,'Ticks',tt)
