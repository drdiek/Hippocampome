function relativeRiskStandardError = relative_risk_standard_error(a, b, c, d)

    relativeRiskStandardError = [sqrt((1/a) - (1/(a+b)) + (1/c) - (1/(c+d))) sqrt((1/b) - (1/(a+b)) + (1/d) - (1/(c+d))); ...
                                 sqrt((1/a) - (1/(a+c)) + (1/b) - (1/(b+d))) sqrt((1/c) - (1/(a+c)) + (1/d) - (1/(b+d)))];

end