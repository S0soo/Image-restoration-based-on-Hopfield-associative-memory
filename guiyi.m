function sk = guiyi(T,m,n)
for i = 1:m                 %�����е�0��Ϊ-1
    for j = 1:n
        if (T(i,j) == 0)
            T(i,j) = -1;
        end
    end
end
sk = T;