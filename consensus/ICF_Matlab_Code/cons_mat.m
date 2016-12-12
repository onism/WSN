function mat_new = cons_mat(cm, mat_cellArray)

mat_new = zeros(size(mat_cellArray{1}, 1), size(mat_cellArray{1}, 2));
for i = 1:size(mat_cellArray{1}, 1)
    for j = 1:size(mat_cellArray{1}, 2)
%         x0 = zeros(length(mat_cellArray), 1);
        x0 = zeros(1, length(mat_cellArray) );
        for k = 1:length(mat_cellArray)
            mat_prev = mat_cellArray{k};
            x0(k) = mat_prev(i, j);
        end
        if norm(x0 - mean(x0) ) <= 1e-10
            x = mean(x0);
        else
            x = cons_cont_elem(cm, x0);
        end
        mat_new(i, j) = x;
    end
end

