function cmplx = fcon(cmplx)
% -------------------------------------------------------------------------
% fcon.m
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% polyhedra
% fcomplex(4).bndop(1).indx - not needed?
% fcomplex(4).bndop(2).indx - not needed?
% fcomplex(4).bndop(3).indx - done
% -------------------------------------------------------------------------
cmplx(4).num(1).val = zeros(cmplx(4).num(4).val,1);
cmplx(4).bndop(1).indx = zeros(cmplx(4).num(4).val,30);
cmplx(4).num(2).val = zeros(cmplx(4).num(4).val,1);
cmplx(4).bndop(2).indx = zeros(cmplx(4).num(4).val,30);
for i=1:cmplx(4).num(4).val
    tmp1 = []; cnt1 = 0;
    tmp2 = []; cnt2 = 0;
    for j=1:cmplx(4).num(3).val(i)
        k = cmplx(4).bndop(3).indx(i,j); p = cmplx(3).num(2).val(k);
        tmp2(cnt2+1:cnt2+p) = cmplx(3).bndop(2).indx(k,1:p);
        cnt2 = cnt2+p;
        for l=1:cmplx(3).num(2).val(k)
            m = cmplx(3).bndop(2).indx(k,l); q = cmplx(2).num(1).val(m);
            tmp1(cnt1+1:cnt1+q) = cmplx(2).bndop(1).indx(m,1:q);
            cnt1 = cnt1+q;
        end
    end
    tmp1 = unique(tmp1); tmp2 = unique(tmp2);
    cmplx(4).bndop(1).indx(i,1:length(tmp1)) = tmp1;
    cmplx(4).num(1).val(i)= max(cmplx(4).num(1).val(i),length(tmp1));
    cmplx(4).bndop(2).indx(i,1:length(tmp2)) = tmp2;
    cmplx(4).num(2).val(i) = max(cmplx(4).num(2).val(i),length(tmp2));
end
cmplx(4).bndop(1).indx = ...
    cmplx(4).bndop(1).indx(:,1:max(cmplx(4).num(1).val));
cmplx(4).bndop(1).sgn = sign(cmplx(4).bndop(1).indx);
cmplx(4).bndop(2).indx = ...
    cmplx(4).bndop(2).indx(:,1:max(cmplx(4).num(2).val));
cmplx(4).bndop(2).sgn = sign(cmplx(4).bndop(2).indx);

% -------------------------------------------------------------------------
% faces
% fcomplex(3).bndop(1).indx - do!!!
% fcomplex(3).bndop(2).indx - done
% fcomplex(3).bndop(4).indx
% -------------------------------------------------------------------------
cmplx(3).num(1).val = zeros(cmplx(3).num(3).val,1);
cmplx(3).bndop(1).indx = zeros(cmplx(3).num(3).val,30);
for i=1:cmplx(3).num(3).val
    tmp = []; cnt = 0;
    for j=1:cmplx(3).num(2).val(i)
        k = cmplx(3).bndop(2).indx(i,j); p = cmplx(2).num(1).val(k);
        tmp(cnt+1:cnt+p) = cmplx(2).bndop(1).indx(k,1:p);
        cnt = cnt+p;
    end
    tmp = unique(tmp);
    cmplx(3).bndop(1).indx(i,1:length(tmp)) = tmp;
    cmplx(3).num(1).val(i)= max(cmplx(3).num(1).val(i),length(tmp));
end
cmplx(3).bndop(1).indx = ...
    cmplx(3).bndop(1).indx(:,1:max(cmplx(3).num(1).val));
cmplx(3).bndop(1).sgn = sign(cmplx(3).bndop(1).indx);

cmplx(3).bndop(4).indx = zeros(cmplx(3).num(3).val,2);
cmplx(3).bndop(4).sgn = zeros(cmplx(3).num(3).val,2);
cmplx(3).num(4).val = zeros(cmplx(3).num(3).val,1);
for i=1:cmplx(4).num(4).val
    for j=1:cmplx(4).num(3).val(i)
        k = cmplx(4).bndop(3).indx(i,j);
        cmplx(3).num(4).val(k) = cmplx(3).num(4).val(k)+1;
        cmplx(3).bndop(4).indx(k,cmplx(3).num(4).val(k)) = i;
        cmplx(3).bndop(4).sgn(k,cmplx(3).num(4).val(k)) = ...
            cmplx(4).bndop(3).sgn(i,j);
    end
end

% -------------------------------------------------------------------------
% edges
% fcomplex(2).bndop(1).indx - done
% fcomplex(2).bndop(3).indx
% fcomplex(2).bndop(4).indx
% -------------------------------------------------------------------------
cmplx(2).bndop(3).indx = zeros(cmplx(2).num(2).val,3);
cmplx(2).bndop(3).sgn = zeros(cmplx(2).num(2).val,3);
cmplx(2).num(3).val = zeros(cmplx(2).num(2).val,1);
for i=1:cmplx(3).num(3).val
    for j=1:cmplx(3).num(2).val(i)
        k = cmplx(3).bndop(2).indx(i,j);
        cmplx(2).num(3).val(k) = cmplx(2).num(3).val(k)+1;
        cmplx(2).bndop(3).indx(k,cmplx(2).num(3).val(k)) = i;
        cmplx(2).bndop(3).sgn(k,cmplx(2).num(3).val(k)) = ...
            cmplx(3).bndop(2).sgn(i,j);
    end
end

cmplx(2).bndop(4).indx = zeros(cmplx(2).num(2).val,3);
cmplx(2).bndop(4).sgn = zeros(cmplx(2).num(2).val,3);
cmplx(2).num(4).val = zeros(cmplx(2).num(2).val,1);
for i=1:cmplx(4).num(4).val
    for j=1:cmplx(4).num(2).val(i)
        k = cmplx(4).bndop(2).indx(i,j);
        cmplx(2).num(4).val(k) = cmplx(2).num(4).val(k)+1;
        cmplx(2).bndop(4).indx(k,cmplx(2).num(4).val(k)) = i;
        cmplx(2).bndop(4).sgn(k,cmplx(2).num(4).val(k)) = ...
            cmplx(4).bndop(2).sgn(i,j);
    end
end

% -------------------------------------------------------------------------
% nodes
% fcomplex(1).bndop(2).indx
% fcomplex(1).bndop(3).indx
% fcomplex(1).bndop(4).indx
% -------------------------------------------------------------------------
cmplx(1).bndop(2).indx = zeros(cmplx(1).num(1).val,4);
cmplx(1).bndop(2).sgn = zeros(cmplx(1).num(1).val,4);
cmplx(1).num(2).val = zeros(cmplx(1).num(1).val,1);
for i=1:cmplx(2).num(2).val
    for j=1:cmplx(2).num(1).val(i)
        k = cmplx(2).bndop(1).indx(i,j);
        cmplx(1).num(2).val(k) = cmplx(1).num(2).val(k)+1;
        cmplx(1).bndop(2).indx(k,cmplx(1).num(2).val(k)) = i;
        cmplx(1).bndop(2).sgn(k,cmplx(1).num(2).val(k)) = ...
            cmplx(2).bndop(1).sgn(i,j);
    end
end

cmplx(1).bndop(3).indx = zeros(cmplx(1).num(1).val,6);
cmplx(1).bndop(3).sgn = zeros(cmplx(1).num(1).val,6);
cmplx(1).num(3).val = zeros(cmplx(1).num(1).val,1);
for i=1:cmplx(3).num(3).val
    for j=1:cmplx(3).num(1).val(i)
        k = cmplx(3).bndop(1).indx(i,j);
        cmplx(1).num(3).val(k) = cmplx(1).num(3).val(k)+1;
        cmplx(1).bndop(3).indx(k,cmplx(1).num(3).val(k)) = i;
        cmplx(1).bndop(3).sgn(k,cmplx(1).num(3).val(k)) = ...
            cmplx(3).bndop(1).sgn(i,j);
    end
end
        
cmplx(1).bndop(4).indx = zeros(cmplx(1).num(1).val,4);
cmplx(1).bndop(4).sgn = zeros(cmplx(1).num(1).val,4);
cmplx(1).num(4).val = zeros(cmplx(1).num(1).val,1);
for i=1:cmplx(4).num(4).val
    for j=1:cmplx(4).num(1).val(i)
        k = cmplx(4).bndop(1).indx(i,j);
        cmplx(1).num(4).val(k) = cmplx(1).num(4).val(k)+1;
        cmplx(1).bndop(4).indx(k,cmplx(1).num(4).val(k)) = i;
        cmplx(1).bndop(4).sgn(k,cmplx(1).num(4).val(k)) = ...
            cmplx(4).bndop(1).sgn(i,j);
    end
end


