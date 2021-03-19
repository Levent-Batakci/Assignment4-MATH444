function x = RandRange(upper, lower, amount)
    x = [(upper-lower) .* rand(1, amount) + lower]';
end

