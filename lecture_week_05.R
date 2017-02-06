#t-tests

> getwd()
[1] "/Users/anissa"
> setwd("/Users/anissa/Github/uwcom521-anissa")
> getwd()
[1] "/Users/anissa/Github/uwcom521-anissa"
> list.files("/Users/anissa/Github/uwcom521-anissa")
[1] "~$week6_dataset_red_dye.xlsx"           
[2] "com521_population.tsv"                  
[3] "COS-Statistics-Mobile_Sessions.csv"     
[4] "COS-Statistics-Top5000-Pages.csv"       
[5] "lecture_week_03.R"                      
[6] "lecture_week_04.R"                      
[7] "lecture_week_05.R"                      
[8] "nc.RData"                               
[9] "week_02_dataset-anissa.RData"           
[10] "week_02_programming_challenges_anissa.R"
[11] "week_03_programming_challenges_anissa.R"
[12] "week_04_programming_challenges_anissa.R"
[13] "week_04_q3.R"                           
[14] "week_05_programming_challenges_anissa.R"
[15] "week_06_programming_challenges_anissa.R"
[16] "week2_dataset-anissa.RData"             
[17] "week3_dataset-anissa.csv"               
[18] "week6_dataset_red_dye.xlsx"             
> load("nc.RData")
> rivers
[1]  735  320  325  392  524  450 1459  135  465  600  330  336
[13]  280  315  870  906  202  329  290 1000  600  505 1450  840
[25] 1243  890  350  407  286  280  525  720  390  250  327  230
[37]  265  850  210  630  260  230  360  730  600  306  390  420
[49]  291  710  340  217  281  352  259  250  470  680  570  350
[61]  300  560  900  625  332 2348 1171 3710 2315 2533  780  280
[73]  410  460  260  255  431  350  760  618  338  981 1306  500
[85]  696  605  250  411 1054  735  233  435  490  310  460  383
[97]  375 1270  545  445 1885  380  300  380  377  425  276  210
[109]  800  420  350  360  538 1100 1205  314  237  610  360  540
[121] 1038  424  310  300  444  301  268  620  215  652  900  525
[133]  246  360  529  500  720  270  430  671 1770
> rnorm(n=length(rivers), mean=100, sd=100)
[1]  -54.607475  174.979737  226.987390  -28.138856  117.606033
[6]   99.002223  282.897418   85.446055  249.720433   31.957340
[11]   18.004691  189.159010   43.663205  126.911936   39.974986
[16]   63.723392  202.572347  107.371401   16.505277  103.857008
[21]  137.150529   56.339635   96.454111  148.909409    8.614265
[26]    5.984034   41.111835   65.365017   20.991556  -22.001924
[31]   -3.012420  -24.063051   13.483441   91.556612   53.699482
[36]  -21.592079   27.200628  -20.539956  135.526941  115.745179
[41]  183.255494   78.246109  183.209778 -168.659321   65.874708
[46]  -48.590169  -29.829982  -95.599986  202.399630  288.945693
[51]   58.452869  171.305542   78.275332  127.558746   92.989456
[56]  220.263011   -6.774049   30.552974  181.096484  126.995060
[61]  -46.330836  177.525296   87.725443  101.139596  160.226898
[66]  125.281399   89.233887  135.219961  188.825036   74.667898
[71]  209.049532  242.578190   39.387565   31.527362   34.601021
[76]  -62.685249  254.829965  -38.100412  193.300783   82.912966
[81]   -6.360146  265.515265   66.420684  145.142061  123.423451
[86]   -9.179451   78.263711   92.038922   78.325843   23.558309
[91]  205.146404   75.065134  166.233036  213.428986  160.665169
[96]   80.658044   23.649928  -89.789211   47.883537   69.827752
[101]   -3.817472  117.232314   87.104532  -22.204640    2.970546
[106]   27.969663  128.006784  226.227811  176.255671  123.471835
[111]  -22.777587   77.186207  158.089486   53.462175   76.121117
[116]  123.399156   -7.802074   -4.121838  -97.428636  -89.482400
[121]  159.960686  166.542044  159.821040  351.139317   74.641632
[126]  -18.142286  206.545252   49.747327   86.597863   42.491525
[131]    2.055360   62.226576    5.929113  -17.856900  123.975774
[136]   36.088277  155.957916  129.203124  112.461188  126.611677
[141]  104.883357
> #Just generated random numbers the same length as "rivers"
  > #So I can add it to rivers
  > new.rivers <- rivers + rnorm(n=length(rivers), mean=100, sd=100)
  > hist(rnorm(n=length(rivers), mean=100, sd=100))
  > hist(rivers)
  > hist(new.rivers)
  > plot(rivers, new.rivers)
  > help("t.test")
  > 
    > 
    > t.test(rivers)
  
  One Sample t-test
  
  data:  rivers
  t = 14.214, df = 140, p-value < 2.2e-16
  alternative hypothesis: true mean is not equal to 0
  95 percent confidence interval:
    508.9559 673.4129
  sample estimates:
    mean of x 
  591.1844 
  
  > t.test(rivers, new.rivers)
  
  Welch Two Sample t-test
  
  data:  rivers and new.rivers
  t = -1.5928, df = 279.56, p-value = 0.1123
  alternative hypothesis: true difference in means is not equal to 0
  95 percent confidence interval:
    -213.77633   22.55395
  sample estimates:
    mean of x mean of y 
  591.1844  686.7956 
  
  > t.test(rivers, new.rivers, paired=TRUE)
  
  Paired t-test
  
  data:  rivers and new.rivers
  t = -11.711, df = 140, p-value < 2.2e-16
  alternative hypothesis: true difference in means is not equal to 0
  95 percent confidence interval:
    -111.75283  -79.46955
  sample estimates:
    mean of the differences 
  -95.61119 
  
  > #Note that these two t tests result in different conclusions.
    > #In the first, we wouldn't reject the null hypothesis.
    > #In the second, we would. 
    > #This is because in the second, the paired t-test, we're only comparing
    > #141 differences in paired means, so we have lower df's.
    > 
    > head(nc)
  fage mage      mature weeks    premie visits marital gained weight
  1   NA   13 younger mom    39 full term     10 married     38   7.63
  2   NA   14 younger mom    42 full term     15 married     20   7.88
  3   19   15 younger mom    37 full term     11 married     38   6.63
  4   21   15 younger mom    41 full term      6 married     34   8.00
  5   NA   15 younger mom    39 full term      9 married     27   6.38
  6   NA   15 younger mom    38 full term     19 married     22   5.38
  lowbirthweight gender     habit  whitemom
  1        not low   male nonsmoker not white
  2        not low   male nonsmoker not white
  3        not low female nonsmoker     white
  4        not low   male nonsmoker     white
  5        not low female nonsmoker not white
  6            low   male nonsmoker not white
  > 
    > 
    > 
    > #Switching over to North Carolina birth dataset now.
    > 
    > #Create new vectors to compare boys and girls
    > 
    > nc$weight
  [1]  7.63  7.88  6.63  8.00  6.38  5.38  8.44  4.69  8.81  6.94
  [11]  7.44  8.81  6.00  7.13  7.56  6.88  5.81  1.50  8.25  6.19
  [21]  7.00  7.19  6.00  7.63  9.50  5.56  7.50  7.44  7.56  6.06
  [31]  7.44  7.00  4.56  2.63  6.38  7.25  1.56  7.44  6.00  6.50
  [41]  7.31  7.88  6.19  7.00  5.81  7.44  7.75  8.00  6.63  8.31
  [51]  7.25  5.50  7.81  7.00  7.31  9.06  6.56  5.88  6.63  9.06
  [61]  8.75  7.06  6.88  5.94  8.56  7.06  8.06  7.44  7.88  6.19
  [71]  6.19  4.44  4.75  5.50  1.69  7.88  7.50  7.88  5.94  8.56
  [81]  9.25  7.69  5.94  9.50  6.06  6.94  8.19  6.75  6.25  8.00
  [91]  8.31  7.75  4.69  5.38  8.38  6.88  6.75  6.94  8.38  7.31
  [101]  7.94  8.38  2.88  5.88  1.38  6.50  6.31  5.25  7.25  6.19
  [111]  9.94  7.31  5.63  6.50  5.63  6.31  9.56  5.44  6.75  8.38
  [121]  7.19  7.19  6.06  7.19  5.94  8.56  6.69  7.50  7.44  7.88
  [131]  8.75  7.44  7.44  6.38  8.81  7.00  7.19  5.94  6.75  8.13
  [141]  6.38  7.13  6.88  8.44  8.31  7.25  6.06  5.75  6.75  8.06
  [151]  9.00  6.25  7.06  8.00  8.31  7.75  7.44  8.44  8.25  6.69
  [161]  5.25  6.31  7.50  7.44  9.06  7.38  5.38  6.94  4.50  6.38
  [171]  7.63  4.50  4.94  6.13  4.13  2.69  7.75  8.38  6.81  6.00
  [181]  9.56  7.56  7.44  7.38  5.94  7.00  6.94  6.94  6.38  7.19
  [191]  7.63  8.38  7.50  7.88  7.63  7.75  5.44  6.50  8.06  6.75
  [201]  8.19  5.88  8.06  6.88  9.06  7.13  8.13  6.75  7.88  7.69
  [211]  7.69  7.44  6.38  9.13  8.31  5.06  8.63  5.44  5.81  4.25
  [221]  9.88  6.81  2.50  5.94  7.56  4.63  5.50  7.25  6.50  8.19
  [231]  6.75  8.00  8.38  8.25  6.88  7.50  7.50  8.44  7.94  9.00
  [241]  7.50  7.69  7.19  7.25  7.44  7.69  7.81  6.69  5.44  7.00
  [251]  7.69 10.19  7.25  9.00  5.88  7.06  7.50  8.56  7.38  7.19
  [261]  6.00  5.81  8.00  6.38  7.19  8.38  8.44  7.31  7.31  6.25
  [271]  7.81  6.63  6.88  6.94  6.00  7.81  6.38  8.38  6.31  7.13
  [281]  6.50  5.00  4.69  3.75  5.88  2.69  1.00  7.19  8.88  8.81
  [291]  6.75  6.81  6.44  9.88  6.88  8.75  6.69  7.88  5.88  9.00
  [301]  7.75  6.06  7.00  5.38  7.31  8.44  7.63  8.44  6.88  8.38
  [311]  8.38  7.63  7.81  8.19  7.31  7.50  7.25  7.13  7.81  8.69
  [321]  8.13  7.31  5.75  7.31  7.50  1.19  5.88  9.25  6.25  1.44
  [331]  8.56  5.13  5.44  6.69  5.50  6.44  5.88  7.25  8.19  5.94
  [341]  7.13  6.69 10.06  7.81  6.31  8.19  7.31  7.63  7.69  9.00
  [351]  5.88  7.13  8.75  6.50  8.38  3.75  7.44  9.13  7.31  6.31
  [361]  6.25  8.50  8.31  6.56  7.13  5.94  7.50  7.19  6.88  6.63
  [371]  7.06  7.19  6.94  7.81  8.50  7.25  8.50  7.06  5.75  6.13
  [381]  7.19  8.13  6.88  7.38  7.13  7.50  5.00  5.81  7.50  8.13
  [391]  5.06  7.38  6.25  8.75  6.94  8.13  8.25  8.00  6.31  7.75
  [401]  7.75  7.06  7.88  7.69  7.94  6.88  6.75  7.94  8.75  8.56
  [411]  7.38  3.94  8.75  8.19  9.19  6.06  7.44  7.38  8.06  7.56
  [421]  6.88  7.75  7.63  9.38  8.31  7.63  6.88  5.63  8.38  9.00
  [431]  8.75  7.94  7.00  5.81  6.00  7.31  9.06  5.94  6.50  6.75
  [441]  5.19  1.69  6.13  7.13  4.50  6.88  7.19  5.94  9.00  7.25
  [451]  7.19  6.94  7.13  7.56  8.25  8.38  6.75  5.38  7.13  8.75
  [461]  7.75  8.44  8.00  8.19  7.94  7.38  9.31  8.88  8.06  7.06
  [471]  6.56  8.19  8.31  5.88  7.44  7.44  6.75  7.44  7.50  6.56
  [481]  7.00  7.69  8.00  7.31  9.13  7.13  7.31  7.38  7.75  8.00
  [491]  2.25  8.19  3.44  6.50  4.00  7.50  8.00  8.00  6.63  6.75
  [501]  7.44  6.25  6.56  5.63  4.56  8.50  8.88  6.25  7.06  7.94
  [511]  6.31  9.06  9.13  7.06  8.25  7.75  8.25  5.75  7.69  6.69
  [521]  7.75  6.81  8.00  6.56  9.63  8.25  7.56  7.19  7.25  6.25
  [531]  8.88  8.56  6.75  7.56  7.81  8.38  7.00  7.69  1.38  4.06
  [541]  7.38  5.56  4.75  7.44  6.75  8.38  7.81  8.13  8.06  7.38
  [551]  9.25  7.63  8.38  7.50  8.00  8.13  7.31  7.56  7.44  7.06
  [561]  7.50  7.25  8.56  7.94  8.13  7.06  6.44  5.81  8.44  6.44
  [571]  7.56  8.25  6.38  7.13  5.56  6.88  7.75  7.25  7.75  8.13
  [581]  8.19  8.50  5.69  6.38  8.25  7.44  7.00  7.94  1.88  3.56
  [591]  6.25  3.19  7.31  6.13  4.06  3.31  7.38  7.88  8.94  8.06
  [601]  7.69  8.56  7.13  9.81  6.81  8.31  8.44  6.94  8.50  7.88
  [611]  7.94  7.00  7.81  5.38  6.25  6.19  7.88  6.50  7.00  7.13
  [621]  7.69  9.56  6.50  7.44  6.31  8.50  7.31  5.00  5.44  6.81
  [631]  6.31  9.75  8.25  6.63  7.56  7.81  6.81  7.69  5.69  8.69
  [641]  5.44  7.94  7.38  1.00  6.00  6.00  4.88  5.94  8.25  6.06
  [651]  6.56  8.19  8.63  6.75  8.13  5.81  9.75  7.63  4.56  8.75
  [661]  7.13  7.31  5.63  8.44  7.88  7.25 11.75  6.88  7.50  6.88
  [671]  7.63  8.38  7.56  7.81  6.50  6.88  6.38  6.00  6.50  7.25
  [681]  4.19  7.06  6.06  2.94  6.00  5.50  9.19  8.69  8.00  6.81
  [691]  6.56  9.19  9.19  7.44  7.38  7.81  7.81  7.88  8.00  6.56
  [701]  6.13  7.44  7.63  7.50  6.31  5.25  4.75  7.25  8.13  9.25
  [711]  8.06  6.63  7.13  6.38  9.50  7.13  8.81  7.88  6.25  8.00
  [721]  7.88 10.38  8.81  6.50  7.00  8.19  7.63  7.19  7.06  6.00
  [731]  7.06  8.13  1.31  2.88  6.00  5.94  5.25  4.75  5.94  7.19
  [741]  4.75  6.13  9.38  7.13  7.38  7.44  5.81  9.13  6.25  8.50
  [751] 11.63  6.75  5.56  6.00  6.69  9.50  8.88  9.19  9.31  7.38
  [761]  8.88  6.19  8.81  7.31  7.38  5.00  9.25  6.69  6.81  3.00
  [771]  4.63  5.56  4.44  1.44  1.50  5.06  4.44  6.81  8.81  6.56
  [781]  6.75  7.94  7.31  6.44  3.94  8.06  9.25  7.38  7.38  7.56
  [791]  8.81  6.00  6.88  8.06  6.69  7.06  6.88  9.63  7.88  8.88
  [801]  7.81  7.38  7.50  7.31  8.25  6.56  8.81  7.88  8.31  5.88
  [811]  8.63  9.31  7.88  9.63 10.06  7.13  6.81  8.19  9.13  5.63
  [821]  6.56  6.31  7.13  8.19  8.00  8.63  6.69  6.38  8.50  6.81
  [831]  7.88  7.56  7.25  6.88  8.50  8.50  4.75  8.75  6.44  7.00
  [841]  7.25  8.25  8.50  7.44  7.75  8.50  8.13  6.94  7.25  9.69
  [851]  6.31  6.75  6.88  8.75  9.31  7.88  7.63  8.31  7.88  7.56
  [861]  6.19  7.94  7.19  6.31  4.69  3.81  2.88 10.13  7.06  8.56
  [871]  6.94  8.81  8.44  8.13  7.63  8.44  8.88  8.25  7.88  7.31
  [881]  7.88  7.50  5.19  8.06  8.94  7.69  6.63  7.63  7.56  6.38
  [891]  6.25  7.13  7.94  6.44  5.63  6.50  6.44  8.69  5.63  2.25
  [901]  6.75  1.63  8.88  7.06  8.81  7.56  9.19  6.19  5.38  7.19
  [911]  6.75  7.38  6.06  6.88  7.00  8.56  8.19  7.00  8.13  9.13
  [921]  7.81  7.00  8.25  8.00 10.25  7.69  7.06  7.06  5.38  6.88
  [931]  3.25  4.00  4.13  5.13  9.88  6.19  7.81  8.75  9.31  7.00
  [941]  6.69  8.63  8.50  8.94  6.31  7.25  7.00  7.94  6.25  7.94
  [951]  8.31  8.50  8.38  7.50  8.19  4.94  5.94  4.31  3.63  8.75
  [961]  7.00  6.25  8.94  8.38  7.56  7.75  7.25 10.13  1.38  5.50
  [971]  2.19  8.06  7.81  7.50  7.19  6.06  6.75  5.50  7.31  9.88
  [981]  9.19  8.13  9.00  7.44  5.69  7.81  6.69  3.63  6.38  7.44
  [991]  5.88  7.69  7.56  6.56  5.69  8.44  6.19  6.94  4.56  7.13
  > head(nc)
  fage mage      mature weeks    premie visits marital gained weight
  1   NA   13 younger mom    39 full term     10 married     38   7.63
  2   NA   14 younger mom    42 full term     15 married     20   7.88
  3   19   15 younger mom    37 full term     11 married     38   6.63
  4   21   15 younger mom    41 full term      6 married     34   8.00
  5   NA   15 younger mom    39 full term      9 married     27   6.38
  6   NA   15 younger mom    38 full term     19 married     22   5.38
  lowbirthweight gender     habit  whitemom
  1        not low   male nonsmoker not white
  2        not low   male nonsmoker not white
  3        not low female nonsmoker     white
  4        not low   male nonsmoker     white
  5        not low female nonsmoker not white
  6            low   male nonsmoker not white
  > weight.boys <- nc$weight[nc$gender == "male"]
  > head(weight.boys)
  [1] 7.63 7.88 8.00 5.38 8.44 4.69
  > length(weight.boys)
  [1] 497
  > weight.girls <- nc$weight[nc$gender == "female"]
  > length(weight.girls)
  [1] 503
  > t.test(weight.boys, weight.girls)
  
  Welch Two Sample t-test
  
  data:  weight.boys and weight.girls
  t = 4.2113, df = 996.45, p-value = 2.769e-05
  alternative hypothesis: true difference in means is not equal to 0
  95 percent confidence interval:
    0.2128778 0.5843749
  sample estimates:
    mean of x mean of y 
  7.301509  6.902883 
  
  > #Reject the null. Very small p-value. 
    > 
    > #Can also write that this way, though: t.test(weight ~ gender)
    > #Splits weight variable into groups based on gender. 
    > t.test (weight ~ gender, data=nc)
  
  Welch Two Sample t-test
  
  data:  weight by gender
  t = -4.2113, df = 996.45, p-value = 2.769e-05
  alternative hypothesis: true difference in means is not equal to 0
  95 percent confidence interval:
    -0.5843749 -0.2128778
  sample estimates:
    mean in group female   mean in group male 
  6.902883             7.301509 
  
  > #The tilde "~" indicates a formula, used to pass a description 
    > #of the data into a function
    > 
    > 
    > #Might want to do Anova
    > 
    > head(mtcars)
  mpg cyl disp  hp drat    wt  qsec vs am gear carb
  Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
  Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
  Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
  Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
  Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
  Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
  > 
    > 
    > #See if there's a difference between mean horse power for different 
    > #types of gears
    > 
    > aov(hp ~ gear, data=mtcars)
  Call:
    aov(formula = hp ~ gear, data = mtcars)
  
  Terms:
    gear Residuals
  Sum of Squares    2302.71 143424.16
  Deg. of Freedom         1        30
  
  Residual standard error: 69.14337
  Estimated effects may be unbalanced
  > class(aov(hp ~ gear, data=mtcars))
  [1] "aov" "lm" 
  > #special object associated with that function.
    > #so save it into a variable so it's something recognizable to you. 
    > hp.gear.model <- aov(hp ~ gear, data=mtcars)
  > summary(hp.gear.model)
  Df Sum Sq Mean Sq F value Pr(>F)
  gear         1   2303    2303   0.482  0.493
  Residuals   30 143424    4781               
  > 
    > 
    > #Do same thing from nc data
    > 
    > #Can just do summary() of the ANOVA function instead of passing
    > #it into a new variable, if you want
    > 
    > summary(aov(weight ~ gender, data=nc))
  Df Sum Sq Mean Sq F value   Pr(>F)    
  gender        1   39.7   39.72   17.74 2.76e-05 ***
    Residuals   998 2234.7    2.24                     
  ---
    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
  > 
    > #Very similar from t-test, but not quite identical.
    > #Result is the same, though, in terms of the hypothesis test
    > #Will almost always lead to the same conclusion
  
    
    > #for loops
    >     
    > names <- c("mako", "mika", "lucy")
  > for (current.name in names) {
    +   print(current.name)
    + }
  [1] "mako"
  [1] "mika"
  [1] "lucy"
  > #like lapply
    > 
    >   lapply(names, function(current.name) (print(current.name)))
  [1] "mako"
  [1] "mika"
  [1] "lucy"
  [[1]]
  [1] "mako"
  
  [[2]]
  [1] "mika"
  
  [[3]]
  [1] "lucy"
  
  > 
    > #Do the same thing, except lapply() gives each one separately
    > #Other differences: In function, what happens in function
    > #Stays in function, except for the return value
    > #Wants us to recognize for loops, but applying functions
    > #(e.g. replicate(), lapply()) is is more idiomatic of r.
    >   
    > 
    >   names <- c("mako", "mika", "lucy")
  >   for (current.name in names) {
    +     print(current.name)
    +   }
  [1] "mako"
  [1] "mika"
  [1] "lucy"
  >   
    >   if (TRUE) {
      +     print("this worked!")
      +   }
  [1] "this worked!"
  >   
    >   if (length(names) > 4) {
      +     print("this worked!")
      +   }
  > 
    >   
    > #In a lot of other languages, this is how you would do something to 
    > #items in a list. But not in R ... in R, you use a lot of indexing.
    > #Sometimes it makes sense though. 
    > #E.g:
    >   
    > #my.function <- function (input.list, my.option=FALS) {
    >   #if (my.option) {
    >     #run.some.function(input.list)
    >   #} else {
    >     
    >   #}
    >   #}
    > #}
    >   
    > #Not running that code, just wants us to be able to read it. 
    >   
    > for (i in seq(0,10)) {
      +   print(i)
      + }
  [1] 0
  [1] 1
  [1] 2
  [1] 3
  [1] 4
  [1] 5
  [1] 6
  [1] 7
  [1] 8
  [1] 9
  [1] 10
  >  
    >   
    >   for (i in seq(0,10)) {
      +     if (i < 2) {
        +       next
        +     }
      +     print(i)
      +   }
  [1] 2
  [1] 3
  [1] 4
  [1] 5
  [1] 6
  [1] 7
  [1] 8
  [1] 9
  [1] 10
  >   
    >   for (i in seq(0,10)) {
      +     if (i < 2 | i > 4) {
        +       next
        +     }
      +     print(i)
      +   }
  [1] 2
  [1] 3
  [1] 4
  >   
    > # "|" means "or"
    > 