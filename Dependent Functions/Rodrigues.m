% Rodrigues's formula for Vector Rotation: This function provides the
% rotation matrix to rotate vector N to V. N and V are 1x3 matrices
function Rot=Rodrigues(N,V)
    teta=acos(dot(N,V)/norm(N)/norm(V));
    k=cross(N,V);
    if norm(k)==0
        Rot=eye(length(N),length(N));
    else
        k=k/norm(k);
        K=[0,-k(3),k(2);k(3),0,-k(1);-k(2),k(1),0];
        R=eye(3)+sin(teta)*K+(1-cos(teta))*K^2;
        Rot=R';
    end
end