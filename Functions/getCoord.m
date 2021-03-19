function coord = getCoord(x, N)
    coord = [floor((x-1)/N)+1 mod(x-1,N)+1]';
end

