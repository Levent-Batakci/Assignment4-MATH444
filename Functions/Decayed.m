function x = Decayed(t, x0, x1, T)
    x = max(x0 * (1-t/T), x1);
end

