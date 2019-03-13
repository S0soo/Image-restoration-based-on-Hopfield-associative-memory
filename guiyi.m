function sk = guiyi(T,m,n)
for i = 1:m                 %矩阵中的0变为-1
    for j = 1:n
        if (T(i,j) == 0)
            T(i,j) = -1;
        end
    end
end
sk = T;