function oddsRatioStandardError = odd_ratio_standard_error(a, b, c, d)

    se_ln_OR = sqrt((1/a) + (1/b) + (1/c) + (1/d));

    oddsRatioStandardError = [se_ln_OR se_ln_OR; ...
                              se_ln_OR se_ln_OR];
                          
end