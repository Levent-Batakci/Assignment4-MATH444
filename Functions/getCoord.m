function coord = getCoord(x, k)
    coord = [x-mod(x,k)+1 mod(x,k)+1]';
end

