function createCSVmotifList()
    % self1 self2 E/I1 E/I2 return
    Mot2 = [0 0 1 1 0; ...
        0 0 1 -1 0; ...
        0 1 1 1 0; ...
        0 -1 1 -1 0; ...

        0 0 -1 1 0; ...
        0 0 -1 -1 0; ...
        0 1 -1 1 0; ...
        0 -1 -1 -1 0; ...

        1 0 1 1 0; ...
        1 0 1 -1 0; ...
        1 1 1 1 0; ...
        1 -1 1 -1 0; ...

        -1 0 -1 1 0; ...
        -1 0 -1 -1 0; ...
        -1 1 -1 1 0; ...
        -1 -1 -1 -1 0; ...


        0 0 1 1 1; ...
        0 0 1 -1 -1; ...
        0 0 -1 1 1; ...
        0 1 1 1 1; ...
        1 0 1 1 1; ...
        0 -1 1 -1 -1; ...
        -1 0 -1 1 1; ...

        0 0 -1 -1 -1; ...
        0 1 -1 1 1; ...
        1 0 1 -1 -1; ...
        0 -1 -1 -1 -1; ...
        -1 0 -1 -1 -1; ...

        1 1 1 1 1; ...
        1 -1 1 -1 -1; ...
        -1 1 -1 1 1; ...

        -1 -1 -1 -1 -1; ]; 
    
        

    fidCSV = fopen('_motifList.txt', 'wt');
    fprintf(fidCSV, 'superClass\tclass\tclassDupIDs(class)\t EorIA\tEorIB\tEorIC\t ConnA\tConnA\tConnA\t ConnB\tConnB\tConnB\t ConnC\tConnC\tConnC\n');

    Mot3 = zeros(3456,12);
    ID3 = zeros(3456,1);
    classDupIDs = [ 1; 2; 3; 4; 5; 21; 37; 53; 9; 25; 41; 57; 13; 29; 45; 61; 2; 18; 34; 50; 21; 22; 23; 24; 25; 26; 42; 58; 29; 30; 46; 62; 3; 34; 35; 36; 37; 23; 39; 40; 41; 42; 43; 44; 45; 46; 47; 63; 4; 50; 36; 52; 53; 24; 40; 56; 57; 58; 44; 60; 61; 62; 63; 64; 65; 66; 67; 68; 69; 70; 71; 72; 73; 74; 75; 76; 77; 78; 79; 80; 81; 82; 83; 84; 85; 86; 87; 88; 89; 90; 91; 92; 93; 94; 95; 96; 97; 98; 99; 100; 101; 102; 103; 104; 105; 106; 107; 108; 109; 110; 111; 112; 113; 114; 115; 116; 117; 118; 119; 120; 121; 122; 123; 124; 125; 126; 127; 128; 129; 130; 131; 132; 130; 134; 138; 142; 131; 138; 139; 140; 132; 142; 140; 144; 145; 149; 153; 157; 149; 150; 151; 152; 153; 151; 155; 156; 157; 152; 156; 160; 161; 165; 169; 173; 165; 166; 170; 174; 169; 170; 171; 172; 173; 174; 172; 176; 177; 181; 185; 189; 181; 182; 186; 190; 185; 186; 187; 191; 189; 190; 191; 192; 193; 194; 195; 196; 197; 198; 199; 200; 201; 202; 203; 204; 205; 206; 207; 208; 209; 210; 211; 212; 213; 214; 215; 216; 217; 218; 219; 220; 221; 222; 223; 224; 225; 226; 227; 228; 229; 230; 231; 232; 233; 234; 235; 236; 237; 238; 239; 240; 241; 242; 243; 244; 245; 246; 247; 248; 249; 250; 251; 252; 253; 254; 255; 256; 257; 258; 259; 260; 261; 262; 263; 264; 265; 266; 267; 268; 269; 270; 271; 272; 273; 274; 275; 276; 277; 278; 279; 280; 281; 282; 283; 284; 285; 286; 287; 288; 289; 290; 291; 292; 293; 294; 295; 296; 297; 298; 299; 300; 301; 302; 303; 304; 305; 306; 307; 308; 309; 310; 311; 312; 313; 314; 315; 316; 317; 318; 319; 320; 321; 322; 323; 324; 325; 326; 327; 328; 329; 330; 331; 332; 333; 334; 335; 336; 337; 338; 339; 340; 341; 342; 343; 344; 345; 346; 347; 348; 349; 350; 351; 352; 353; 354; 355; 356; 357; 358; 359; 360; 361; 362; 363; 364; 365; 366; 367; 368; 369; 370; 371; 372; 373; 374; 375; 376; 377; 378; 379; 380; 381; 382; 383; 384; 385; 386; 387; 388; 386; 390; 391; 392; 387; 403; 395; 435; 388; 404; 399; 400; 386; 390; 403; 404; 390; 406; 422; 438; 391; 422; 411; 439; 392; 438; 415; 416; 387; 391; 395; 399; 403; 422; 411; 415; 395; 411; 427; 443; 435; 439; 443; 432; 388; 392; 435; 400; 404; 438; 439; 416; 399; 415; 443; 432; 400; 416; 432; 448; 449; 450; 451; 452; 453; 466; 467; 468; 457; 482; 483; 484; 461; 498; 499; 500; 453; 466; 467; 468; 469; 470; 471; 472; 485; 474; 487; 488; 501; 478; 503; 504; 457; 482; 483; 484; 485; 474; 487; 488; 489; 490; 491; 492; 505; 506; 495; 508; 461; 498; 499; 500; 501; 478; 503; 504; 505; 506; 495; 508; 509; 510; 511; 512; 513; 514; 515; 516; 517; 533; 549; 565; 521; 537; 553; 569; 525; 541; 557; 573; 514; 530; 546; 562; 533; 534; 535; 536; 537; 538; 554; 570; 541; 542; 558; 574; 515; 546; 547; 548; 549; 535; 551; 552; 553; 554; 555; 556; 557; 558; 559; 575; 516; 562; 548; 564; 565; 536; 552; 568; 569; 570; 556; 572; 573; 574; 575; 576; 577; 578; 579; 580; 581; 582; 583; 584; 585; 586; 587; 588; 589; 590; 591; 592; 593; 594; 595; 596; 597; 598; 599; 600; 601; 602; 603; 604; 605; 606; 607; 608; 609; 610; 611; 612; 613; 614; 615; 616; 617; 618; 619; 620; 621; 622; 623; 624; 625; 626; 627; 628; 629; 630; 631; 632; 633; 634; 635; 636; 637; 638; 639; 640; 641; 642; 643; 644; 645; 661; 677; 693; 649; 665; 681; 697; 653; 669; 685; 701; 642; 658; 674; 690; 661; 662; 663; 664; 665; 666; 682; 698; 669; 670; 686; 702; 643; 674; 675; 676; 677; 663; 679; 680; 681; 682; 683; 684; 685; 686; 687; 703; 644; 690; 676; 692; 693; 664; 680; 696; 697; 698; 684; 700; 701; 702; 703; 704; 705; 706; 707; 708; 709; 710; 711; 712; 713; 714; 715; 716; 717; 718; 719; 720; 721; 722; 723; 724; 725; 726; 727; 728; 729; 730; 731; 732; 733; 734; 735; 736; 737; 738; 739; 740; 741; 742; 743; 744; 745; 746; 747; 748; 749; 750; 751; 752; 753; 754; 755; 756; 757; 758; 759; 760; 761; 762; 763; 764; 765; 766; 767; 768; 769; 770; 771; 772; 770; 789; 805; 821; 771; 805; 809; 825; 772; 821; 825; 829; 770; 789; 805; 821; 789; 790; 791; 792; 805; 791; 810; 826; 821; 792; 826; 830; 771; 805; 809; 825; 805; 791; 810; 826; 809; 810; 811; 812; 825; 826; 812; 831; 772; 821; 825; 829; 821; 792; 826; 830; 825; 826; 812; 831; 829; 830; 831; 832;  ];
    binID =       [ 1; 2; 3; 4; 5; 21; 37; 53; 9; 25; 41; 57; 13; 29; 45; 61; 18; 34; 50; 22; 23; 24; 26; 42; 58; 30; 46; 62; 35; 36; 39; 40; 43; 44; 47; 63; 52; 56; 60; 64; 65; 66; 67; 68; 69; 70; 71; 72; 73; 74; 75; 76; 77; 78; 79; 80; 81; 82; 83; 84; 85; 86; 87; 88; 89; 90; 91; 92; 93; 94; 95; 96; 97; 98; 99; 100; 101; 102; 103; 104; 105; 106; 107; 108; 109; 110; 111; 112; 113; 114; 115; 116; 117; 118; 119; 120; 121; 122; 123; 124; 125; 126; 127; 128; 129; 130; 131; 132; 134; 138; 142; 139; 140; 144; 145; 149; 153; 157; 150; 151; 152; 155; 156; 160; 161; 165; 169; 173; 166; 170; 174; 171; 172; 176; 177; 181; 185; 189; 182; 186; 190; 187; 191; 192; 193; 194; 195; 196; 197; 198; 199; 200; 201; 202; 203; 204; 205; 206; 207; 208; 209; 210; 211; 212; 213; 214; 215; 216; 217; 218; 219; 220; 221; 222; 223; 224; 225; 226; 227; 228; 229; 230; 231; 232; 233; 234; 235; 236; 237; 238; 239; 240; 241; 242; 243; 244; 245; 246; 247; 248; 249; 250; 251; 252; 253; 254; 255; 256; 257; 258; 259; 260; 261; 262; 263; 264; 265; 266; 267; 268; 269; 270; 271; 272; 273; 274; 275; 276; 277; 278; 279; 280; 281; 282; 283; 284; 285; 286; 287; 288; 289; 290; 291; 292; 293; 294; 295; 296; 297; 298; 299; 300; 301; 302; 303; 304; 305; 306; 307; 308; 309; 310; 311; 312; 313; 314; 315; 316; 317; 318; 319; 320; 321; 322; 323; 324; 325; 326; 327; 328; 329; 330; 331; 332; 333; 334; 335; 336; 337; 338; 339; 340; 341; 342; 343; 344; 345; 346; 347; 348; 349; 350; 351; 352; 353; 354; 355; 356; 357; 358; 359; 360; 361; 362; 363; 364; 365; 366; 367; 368; 369; 370; 371; 372; 373; 374; 375; 376; 377; 378; 379; 380; 381; 382; 383; 384; 385; 386; 387; 388; 390; 391; 392; 403; 395; 435; 404; 399; 400; 406; 422; 438; 411; 439; 415; 416; 427; 443; 432; 448; 449; 450; 451; 452; 453; 466; 467; 468; 457; 482; 483; 484; 461; 498; 499; 500; 469; 470; 471; 472; 485; 474; 487; 488; 501; 478; 503; 504; 489; 490; 491; 492; 505; 506; 495; 508; 509; 510; 511; 512; 513; 514; 515; 516; 517; 533; 549; 565; 521; 537; 553; 569; 525; 541; 557; 573; 530; 546; 562; 534; 535; 536; 538; 554; 570; 542; 558; 574; 547; 548; 551; 552; 555; 556; 559; 575; 564; 568; 572; 576; 577; 578; 579; 580; 581; 582; 583; 584; 585; 586; 587; 588; 589; 590; 591; 592; 593; 594; 595; 596; 597; 598; 599; 600; 601; 602; 603; 604; 605; 606; 607; 608; 609; 610; 611; 612; 613; 614; 615; 616; 617; 618; 619; 620; 621; 622; 623; 624; 625; 626; 627; 628; 629; 630; 631; 632; 633; 634; 635; 636; 637; 638; 639; 640; 641; 642; 643; 644; 645; 661; 677; 693; 649; 665; 681; 697; 653; 669; 685; 701; 658; 674; 690; 662; 663; 664; 666; 682; 698; 670; 686; 702; 675; 676; 679; 680; 683; 684; 687; 703; 692; 696; 700; 704; 705; 706; 707; 708; 709; 710; 711; 712; 713; 714; 715; 716; 717; 718; 719; 720; 721; 722; 723; 724; 725; 726; 727; 728; 729; 730; 731; 732; 733; 734; 735; 736; 737; 738; 739; 740; 741; 742; 743; 744; 745; 746; 747; 748; 749; 750; 751; 752; 753; 754; 755; 756; 757; 758; 759; 760; 761; 762; 763; 764; 765; 766; 767; 768; 769; 770; 771; 772; 789; 805; 821; 809; 825; 829; 790; 791; 792; 810; 826; 830; 811; 812; 831; 832; ];

    counter = 1;
    class = 1;

    for superClass = 1:13
        for node1 = 1:4
            switch (node1)
                %blue = excit, no self
                case 1 
                    EorI1 = 1;
                    Self1 = 0;
                %red = inhib, no self
                case 2
                    EorI1 = -1;
                    Self1 = 0;
                %green = excit, self
                case 3
                    EorI1 = 1;
                    Self1 = 1;
                %yellow = inhib, self
                case 4
                    EorI1 = -1;
                    Self1 = -1;
            end

            for node2 = 1:4
                switch (node2)
                    %blue = excit, no self
                    case 1
                        EorI2 = 1;
                        Self2 = 0;
                    %red = inhib, no self
                    case 2
                        EorI2 = -1;
                        Self2 = 0;
                    %green = excit, self
                    case 3
                        EorI2 = 1;
                        Self2 = 1;
                    %yellow = inhib, self
                    case 4
                        EorI2 = -1;
                        Self2 = -1;
                end

                for node3 = 1:4
                    switch (node3)
                        %blue = excit, no self
                        case 1
                            EorI3 = 1;
                            Self3 = 0;
                        %red = inhib, no self
                        case 2
                            EorI3 = -1;
                            Self3 = 0;
                        %green = excit, self
                        case 3
                            EorI3 = 1;
                            Self3 = 1;
                        %yellow = inhib, self
                        case 4
                            EorI3 = -1;
                            Self3 = -1;
                    end

                    % write out values at all image rotations
                    switch (superClass)
                        case 1
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t0\t %d\t%d\t%d\t 0\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI1, Self2, EorI3, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 0 EorI1 Self2 EorI3 0 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t0\t 0\t%d\t0\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, Self2, EorI1, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 0 0 Self2 0 EorI1 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t 0\t%d\t0\t 0\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI3, Self2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 EorI3 0 Self2 0 0 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));                          
                            
                        case 2
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t%d\t %d\t%d\t0\t 0\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI3, EorI1, Self2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 EorI3 EorI1 Self2 0 0 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t0\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, Self2, EorI1, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 0 0 Self2 0 EorI1 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t0\t %d\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI1, Self2, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 0 EorI1 Self2 0 0 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t%d\t 0\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, Self2, EorI3, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 0 0 Self2 EorI3 0 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t%d\t 0\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI3, Self2, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 EorI3 0 Self2 0 0 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t0\t 0\t%d\t%d\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, Self2, EorI3, EorI1, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 0 0 Self2 EorI3 EorI1 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            
                        case 3
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t0\t %d\t%d\t0\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI1, Self2, EorI1, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 0 EorI1 Self2 0 EorI1 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, Self2, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 0 0 Self2 0 0 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t%d\t 0\t%d\t%d\t 0\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI3, Self2, EorI3, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 EorI3 0 Self2 EorI3 0 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            
                        case 4
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t%d\t 0\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI1, Self2, EorI3, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 0 EorI1 Self2 EorI3 0 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t0\t %d\t%d\t%d\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI1, Self2, EorI3, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 0 EorI1 Self2 EorI3 0 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t0\t 0\t%d\t%d\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, Self2, EorI3, EorI1, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 0 0 Self2 EorI3 EorI1 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t%d\t 0\t%d\t0\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI3, Self2, EorI1, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 EorI3 0 Self2 0 EorI1 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t 0\t%d\t0\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI3, Self2, EorI1, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 EorI3 0 Self2 0 EorI1 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI3, EorI1, Self2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 EorI3 EorI1 Self2 0 0 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                                                        
                        case 5
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t%d\t %d\t%d\t%d\t 0\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI3, EorI1, Self2, EorI3, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 EorI3 EorI1 Self2 EorI3 0 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t0\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, Self2, EorI1, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 0 0 Self2 0 EorI1 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t0\t %d\t%d\t0\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI1, Self2, EorI1, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 0 EorI1 Self2 0 EorI1 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t 0\t%d\t%d\t 0\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI3, Self2, EorI3, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 EorI3 0 Self2 EorI3 0 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t 0\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI3, Self2, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 EorI3 0 Self2 0 0 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t0\t %d\t%d\t%d\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI1, Self2, EorI3, EorI1, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 0 EorI1 Self2 EorI3 EorI1 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                                                        
                        case 6
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI1, Self2, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 0 EorI1 Self2 0 0 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t%d\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, Self2, EorI3, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 0 0 Self2 EorI3 0 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t%d\t 0\t%d\t%d\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI3, Self2, EorI3, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 EorI3 0 Self2 EorI3 0 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t%d\t 0\t%d\t%d\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI3, Self2, EorI3, EorI1, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 EorI3 0 Self2 EorI3 EorI1 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t%d\t %d\t%d\t0\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI3, EorI1, Self2, EorI1, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 EorI3 EorI1 Self2 0 EorI1 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t0\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI1, Self2, EorI1, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 0 EorI1 Self2 0 EorI1 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            
                        case 7
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t%d\t %d\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI3, EorI1, Self2, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 EorI3 EorI1 Self2 0 0 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t%d\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, Self2, EorI3, EorI1, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 0 0 Self2 EorI3 EorI1 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            
                        case 8
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t 0\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI3, EorI1, Self2, EorI3, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 EorI3 EorI1 Self2 EorI3 0 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t0\t %d\t%d\t%d\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI1, Self2, EorI3, EorI1, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 0 EorI1 Self2 EorI3 EorI1 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t 0\t%d\t0\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI3, Self2, EorI1, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 EorI3 0 Self2 0 EorI1 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            
                        case 9
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t%d\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI1, Self2, EorI3, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 0 EorI1 Self2 EorI3 0 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t%d\t 0\t%d\t%d\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI3, Self2, EorI3, EorI1, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 EorI3 0 Self2 EorI3 EorI1 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI3, EorI1, Self2, EorI1, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 EorI3 EorI1 Self2 0 EorI1 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            
                        case 10
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t%d\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI1, Self2, EorI3, EorI1, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 0 EorI1 Self2 EorI3 EorI1 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI3, EorI1, Self2, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 EorI3 EorI1 Self2 0 0 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t%d\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, Self2, EorI3, EorI1, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 0 0 Self2 EorI3 EorI1 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t%d\t %d\t%d\t%d\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI3, EorI1, Self2, EorI3, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 EorI3 EorI1 Self2 EorI3 0 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t 0\t%d\t%d\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI3, Self2, EorI3, EorI1, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 EorI3 0 Self2 EorI3 EorI1 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t%d\t %d\t%d\t0\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI3, EorI1, Self2, EorI1, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 EorI3 EorI1 Self2 0 EorI1 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            
                        case 11
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t%d\t %d\t%d\t%d\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI3, EorI1, Self2, EorI3, EorI1, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 EorI3 EorI1 Self2 EorI3 EorI1 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t0\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI1, Self2, EorI1, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 0 EorI1 Self2 0 EorI1 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t 0\t%d\t%d\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI3, Self2, EorI3, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 EorI3 0 Self2 EorI3 0 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            
                        case 12
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI3, EorI1, Self2, EorI3, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 EorI3 EorI1 Self2 EorI3 0 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t%d\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI1, Self2, EorI3, EorI1, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 0 EorI1 Self2 EorI3 EorI1 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t%d\t %d\t%d\t%d\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI3, EorI1, Self2, EorI3, EorI1, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 0 EorI3 EorI1 Self2 EorI3 EorI1 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t 0\t%d\t%d\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI3, Self2, EorI3, EorI1, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 EorI3 0 Self2 EorI3 EorI1 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI3, EorI1, Self2, EorI1, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 EorI3 EorI1 Self2 0 EorI1 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI3, EorI1, Self2, EorI3, EorI1, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 EorI3 EorI1 Self2 EorI3 EorI1 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            
                        case 13
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI2, EorI3, EorI1, Self2, EorI3, EorI1, EorI2, Self3);
                            Mot3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI2 EorI3 EorI1 Self2 EorI3 EorI1 EorI2 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                                                    
                    end
                    
                    counter = counter + 1;
                    class = class + 1;

                end
            end
        end
    end
    
    save newMotifLib Mot2 Mot3 ID3;
    fclose(fidCSV);
end