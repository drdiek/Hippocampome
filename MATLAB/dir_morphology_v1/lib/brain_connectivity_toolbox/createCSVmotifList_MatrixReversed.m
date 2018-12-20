function createCSVmotifList_MatrixReversed()

fidCSV = fopen('_motifList.txt', 'wt');
fprintf(fidCSV, 'superClass\tclass\tclassDupIDs(class)\t EorIA\tEorIB\tEorIC\t ConnA\tConnA\tConnA\t ConnB\tConnB\tConnB\t ConnC\tConnC\tConnC\n');

    M3 = zeros(3456,12);
    ID3 = zeros(3456,1);
    classDupIDs = [ 1; 2; 3; 4; 5; 18; 19; 20; 9; 34; 35; 36; 13; 50; 51; 52; 5; 18; 19; 20; 21; 22; 23; 24; 37; 26; 39; 40; 53; 30; 55; 56; 9; 34; 35; 36; 37; 26; 39; 40; 41; 42; 43; 44; 45; 46; 47; 60; 13; 50; 51; 52; 53; 30; 55; 56; 45; 46; 47; 60; 61; 62; 63; 64; 65; 66; 67; 68; 69; 70; 71; 72; 73; 74; 75; 76; 77; 78; 79; 80; 81; 82; 83; 84; 85; 86; 87; 88; 89; 90; 91; 92; 93; 94; 95; 96; 97; 98; 99; 100; 101; 102; 103; 104; 105; 106; 107; 108; 109; 110; 111; 112; 113; 114; 115; 116; 117; 118; 119; 120; 121; 122; 123; 124; 125; 126; 127; 128; 129; 133; 137; 141; 133; 134; 135; 136; 137; 135; 139; 143; 141; 136; 143; 144; 145; 146; 147; 148; 146; 150; 154; 158; 147; 154; 155; 159; 148; 158; 159; 160; 161; 162; 163; 164; 162; 166; 167; 168; 163; 167; 171; 175; 164; 168; 175; 176; 177; 178; 179; 180; 178; 182; 183; 184; 179; 183; 187; 188; 180; 184; 188; 192; 193; 194; 195; 196; 197; 198; 199; 200; 201; 202; 203; 204; 205; 206; 207; 208; 209; 210; 211; 212; 213; 214; 215; 216; 217; 218; 219; 220; 221; 222; 223; 224; 225; 226; 227; 228; 229; 230; 231; 232; 233; 234; 235; 236; 237; 238; 239; 240; 241; 242; 243; 244; 245; 246; 247; 248; 249; 250; 251; 252; 253; 254; 255; 256; 257; 258; 259; 260; 261; 262; 263; 264; 265; 266; 267; 268; 269; 270; 271; 272; 273; 274; 275; 276; 277; 278; 279; 280; 281; 282; 283; 284; 285; 286; 287; 288; 289; 290; 291; 292; 293; 294; 295; 296; 297; 298; 299; 300; 301; 302; 303; 304; 305; 306; 307; 308; 309; 310; 311; 312; 313; 314; 315; 316; 317; 318; 319; 320; 321; 322; 323; 324; 325; 326; 327; 328; 329; 330; 331; 332; 333; 334; 335; 336; 337; 338; 339; 340; 341; 342; 343; 344; 345; 346; 347; 348; 349; 350; 351; 352; 353; 354; 355; 356; 357; 358; 359; 360; 361; 362; 363; 364; 365; 366; 367; 368; 369; 370; 371; 372; 373; 374; 375; 376; 377; 378; 379; 380; 381; 382; 383; 384; 385; 389; 393; 397; 389; 402; 418; 434; 393; 403; 419; 435; 397; 404; 420; 436; 389; 402; 403; 404; 402; 406; 410; 414; 418; 410; 423; 439; 434; 414; 424; 440; 393; 418; 419; 420; 403; 410; 423; 424; 419; 423; 427; 431; 435; 439; 431; 444; 397; 434; 435; 436; 404; 414; 439; 440; 420; 424; 431; 444; 436; 440; 444; 448; 449; 453; 457; 461; 453; 454; 455; 456; 457; 455; 459; 460; 461; 456; 460; 464; 465; 466; 467; 468; 469; 466; 474; 478; 467; 474; 475; 476; 468; 478; 476; 480; 481; 482; 483; 484; 482; 486; 487; 488; 483; 487; 491; 495; 484; 488; 495; 496; 497; 498; 499; 500; 498; 502; 503; 504; 499; 503; 507; 508; 500; 504; 508; 512; 513; 514; 515; 516; 517; 530; 531; 532; 521; 546; 547; 548; 525; 562; 563; 564; 517; 530; 531; 532; 533; 534; 535; 536; 549; 538; 551; 552; 565; 542; 567; 568; 521; 546; 547; 548; 549; 538; 551; 552; 553; 554; 555; 556; 557; 558; 559; 572; 525; 562; 563; 564; 565; 542; 567; 568; 557; 558; 559; 572; 573; 574; 575; 576; 577; 578; 579; 580; 581; 582; 583; 584; 585; 586; 587; 588; 589; 590; 591; 592; 593; 594; 595; 596; 597; 598; 599; 600; 601; 602; 603; 604; 605; 606; 607; 608; 609; 610; 611; 612; 613; 614; 615; 616; 617; 618; 619; 620; 621; 622; 623; 624; 625; 626; 627; 628; 629; 630; 631; 632; 633; 634; 635; 636; 637; 638; 639; 640; 641; 642; 643; 644; 645; 658; 677; 693; 649; 665; 675; 697; 653; 669; 685; 692; 645; 658; 674; 690; 661; 662; 663; 664; 665; 666; 679; 698; 669; 670; 686; 696; 649; 674; 675; 676; 677; 666; 679; 680; 681; 682; 683; 684; 685; 686; 687; 700; 653; 690; 676; 692; 693; 670; 680; 696; 697; 698; 687; 700; 701; 702; 703; 704; 705; 706; 707; 708; 709; 710; 711; 712; 713; 714; 715; 716; 717; 718; 719; 720; 721; 722; 723; 724; 725; 726; 727; 728; 729; 730; 731; 732; 733; 734; 735; 736; 737; 738; 739; 740; 741; 742; 743; 744; 745; 746; 747; 748; 749; 750; 751; 752; 753; 754; 755; 756; 757; 758; 759; 760; 761; 762; 763; 764; 765; 766; 767; 768; 769; 773; 777; 781; 773; 786; 787; 788; 777; 787; 803; 804; 781; 788; 804; 820; 773; 786; 787; 788; 786; 790; 794; 798; 787; 794; 807; 808; 788; 798; 808; 824; 777; 787; 803; 804; 787; 794; 807; 808; 803; 807; 811; 815; 804; 808; 815; 828; 781; 788; 804; 820; 788; 798; 808; 824; 804; 808; 815; 828; 820; 824; 828; 832; ];
    binID = [ 1; 2; 3; 4; 5; 18; 19; 20; 9; 34; 35; 36; 13; 50; 51; 52; 21; 22; 23; 24; 37; 26; 39; 40; 53; 30; 55; 56; 41; 42; 43; 44; 45; 46; 47; 60; 61; 62; 63; 64; 65; 66; 67; 68; 69; 70; 71; 72; 73; 74; 75; 76; 77; 78; 79; 80; 81; 82; 83; 84; 85; 86; 87; 88; 89; 90; 91; 92; 93; 94; 95; 96; 97; 98; 99; 100; 101; 102; 103; 104; 105; 106; 107; 108; 109; 110; 111; 112; 113; 114; 115; 116; 117; 118; 119; 120; 121; 122; 123; 124; 125; 126; 127; 128; 129; 133; 137; 141; 134; 135; 136; 139; 143; 144; 145; 146; 147; 148; 150; 154; 158; 155; 159; 160; 161; 162; 163; 164; 166; 167; 168; 171; 175; 176; 177; 178; 179; 180; 182; 183; 184; 187; 188; 192; 193; 194; 195; 196; 197; 198; 199; 200; 201; 202; 203; 204; 205; 206; 207; 208; 209; 210; 211; 212; 213; 214; 215; 216; 217; 218; 219; 220; 221; 222; 223; 224; 225; 226; 227; 228; 229; 230; 231; 232; 233; 234; 235; 236; 237; 238; 239; 240; 241; 242; 243; 244; 245; 246; 247; 248; 249; 250; 251; 252; 253; 254; 255; 256; 257; 258; 259; 260; 261; 262; 263; 264; 265; 266; 267; 268; 269; 270; 271; 272; 273; 274; 275; 276; 277; 278; 279; 280; 281; 282; 283; 284; 285; 286; 287; 288; 289; 290; 291; 292; 293; 294; 295; 296; 297; 298; 299; 300; 301; 302; 303; 304; 305; 306; 307; 308; 309; 310; 311; 312; 313; 314; 315; 316; 317; 318; 319; 320; 321; 322; 323; 324; 325; 326; 327; 328; 329; 330; 331; 332; 333; 334; 335; 336; 337; 338; 339; 340; 341; 342; 343; 344; 345; 346; 347; 348; 349; 350; 351; 352; 353; 354; 355; 356; 357; 358; 359; 360; 361; 362; 363; 364; 365; 366; 367; 368; 369; 370; 371; 372; 373; 374; 375; 376; 377; 378; 379; 380; 381; 382; 383; 384; 385; 389; 393; 397; 402; 418; 434; 403; 419; 435; 404; 420; 436; 406; 410; 414; 423; 439; 424; 440; 427; 431; 444; 448; 449; 453; 457; 461; 454; 455; 456; 459; 460; 464; 465; 466; 467; 468; 469; 474; 478; 475; 476; 480; 481; 482; 483; 484; 486; 487; 488; 491; 495; 496; 497; 498; 499; 500; 502; 503; 504; 507; 508; 512; 513; 514; 515; 516; 517; 530; 531; 532; 521; 546; 547; 548; 525; 562; 563; 564; 533; 534; 535; 536; 549; 538; 551; 552; 565; 542; 567; 568; 553; 554; 555; 556; 557; 558; 559; 572; 573; 574; 575; 576; 577; 578; 579; 580; 581; 582; 583; 584; 585; 586; 587; 588; 589; 590; 591; 592; 593; 594; 595; 596; 597; 598; 599; 600; 601; 602; 603; 604; 605; 606; 607; 608; 609; 610; 611; 612; 613; 614; 615; 616; 617; 618; 619; 620; 621; 622; 623; 624; 625; 626; 627; 628; 629; 630; 631; 632; 633; 634; 635; 636; 637; 638; 639; 640; 641; 642; 643; 644; 645; 658; 677; 693; 649; 665; 675; 697; 653; 669; 685; 692; 674; 690; 661; 662; 663; 664; 666; 679; 698; 670; 686; 696; 676; 680; 681; 682; 683; 684; 687; 700; 701; 702; 703; 704; 705; 706; 707; 708; 709; 710; 711; 712; 713; 714; 715; 716; 717; 718; 719; 720; 721; 722; 723; 724; 725; 726; 727; 728; 729; 730; 731; 732; 733; 734; 735; 736; 737; 738; 739; 740; 741; 742; 743; 744; 745; 746; 747; 748; 749; 750; 751; 752; 753; 754; 755; 756; 757; 758; 759; 760; 761; 762; 763; 764; 765; 766; 767; 768; 769; 773; 777; 781; 786; 787; 788; 803; 804; 820; 790; 794; 798; 807; 808; 824; 811; 815; 828; 832; ];

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
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI1, Self2, EorI3, Self3);
                            M3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI1 0 0 Self2 0 0 EorI3 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI2, EorI1, EorI3, Self2, EorI2, Self1, EorI3, Self3);
                            M3(counter,:) = [EorI2 EorI1 EorI3 Self2 EorI2 0 0 Self1 0 0 EorI3 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI3, EorI1, EorI2, Self3, EorI3, Self1, EorI2, Self2);
                            M3(counter,:) = [EorI3 EorI1 EorI2 Self3 EorI3 0 0 Self1 0 0 EorI2 Self2];
                            ID3(counter) = find(binID == classDupIDs(class));                          
                            
                        case 2
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t0\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI1, Self2, EorI3, Self3);
                            M3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI1 0 0 Self2 0 EorI3 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t0\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI3, EorI2, Self1, EorI1, Self3, EorI2, Self2);
                            M3(counter,:) = [EorI1 EorI3 EorI2 Self1 EorI1 0 0 Self3 0 EorI2 0 Self2];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t0\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI2, EorI1, EorI3, Self2, EorI2, Self1, EorI3, Self3);
                            M3(counter,:) = [EorI2 EorI1 EorI3 Self2 EorI2 0 0 Self1 0 EorI3 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t0\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI2, EorI3, EorI1, Self2, EorI2, Self3, EorI1, Self1);
                            M3(counter,:) = [EorI2 EorI3 EorI1 Self2 EorI2 0 0 Self3 0 EorI1 0 Self1];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t0\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI3, EorI1, EorI2, Self3, EorI3, Self1, EorI2, Self2);
                            M3(counter,:) = [EorI3 EorI1 EorI2 Self3 EorI3 0 0 Self1 0 EorI2 0 Self2];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t0\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI3, EorI2, EorI1, Self3, EorI3, Self2, EorI1, Self1);
                            M3(counter,:) = [EorI3 EorI2 EorI1 Self3 EorI3 0 0 Self2 0 EorI1 0 Self1];
                            ID3(counter) = find(binID == classDupIDs(class));
                            
                        case 3
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t 0\t%d\t0\t 0\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI1, EorI1, Self2, Self3);
                            M3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI1 EorI1 0 Self2 0 0 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t 0\t%d\t0\t 0\t0\t%d\n', superClass, class, classDupIDs(class), EorI2, EorI1, EorI3, Self2, EorI2, EorI2, Self1, Self3);
                            M3(counter,:) = [EorI2 EorI1 EorI3 Self2 EorI2 EorI2 0 Self1 0 0 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t 0\t%d\t0\t 0\t0\t%d\n', superClass, class, classDupIDs(class), EorI3, EorI1, EorI2, Self3, EorI3, EorI3, Self1, Self2);
                            M3(counter,:) = [EorI3 EorI1 EorI2 Self3 EorI3 EorI3 0 Self1 0 0 0 Self2];
                            ID3(counter) = find(binID == classDupIDs(class));
                            
                        case 4
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI1, EorI2, Self2, EorI3, Self3);
                            M3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI1 0 EorI2 Self2 0 0 EorI3 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI3, EorI2, Self1, EorI1, EorI3, Self3, EorI2, Self2);
                            M3(counter,:) = [EorI1 EorI3 EorI2 Self1 EorI1 0 EorI3 Self3 0 0 EorI2 Self2];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI2, EorI1, EorI3, Self2, EorI2, EorI1, Self1, EorI3, Self3);
                            M3(counter,:) = [EorI2 EorI1 EorI3 Self2 EorI2 0 EorI1 Self1 0 0 EorI3 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI2, EorI3, EorI1, Self2, EorI2, EorI3, Self3, EorI1, Self1);
                            M3(counter,:) = [EorI2 EorI3 EorI1 Self2 EorI2 0 EorI3 Self3 0 0 EorI1 Self1];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI3, EorI1, EorI2, Self3, EorI3, EorI1, Self1, EorI2, Self2);
                            M3(counter,:) = [EorI3 EorI1 EorI2 Self3 EorI3 0 EorI1 Self1 0 0 EorI2 Self2];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI3, EorI2, EorI1, Self3, EorI3, EorI2, Self2, EorI1, Self1);
                            M3(counter,:) = [EorI3 EorI2 EorI1 Self3 EorI3 0 EorI2 Self2 0 0 EorI1 Self1];
                            ID3(counter) = find(binID == classDupIDs(class));
                                                        
                        case 5
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t0\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI1, Self2, EorI3, EorI3, Self3);
                            M3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI1 0 0 Self2 0 EorI3 EorI3 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t0\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI3, EorI2, Self1, EorI1, Self3, EorI2, EorI2, Self2);
                            M3(counter,:) = [EorI1 EorI3 EorI2 Self1 EorI1 0 0 Self3 0 EorI2 EorI2 Self2];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t0\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI2, EorI1, EorI3, Self2, EorI2, Self1, EorI3, EorI3, Self3);
                            M3(counter,:) = [EorI2 EorI1 EorI3 Self2 EorI2 0 0 Self1 0 EorI3 EorI3 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t0\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI2, EorI3, EorI1, Self2, EorI2, Self3, EorI1, EorI1, Self1);
                            M3(counter,:) = [EorI2 EorI3 EorI1 Self2 EorI2 0 0 Self3 0 EorI1 EorI1 Self1];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t0\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI3, EorI1, EorI2, Self3, EorI3, Self1, EorI2, EorI2, Self2);
                            M3(counter,:) = [EorI3 EorI1 EorI2 Self3 EorI3 0 0 Self1 0 EorI2 EorI2 Self2];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t0\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI3, EorI2, EorI1, Self3, EorI3, Self2, EorI1, EorI1, Self1);
                            M3(counter,:) = [EorI3 EorI2 EorI1 Self3 EorI3 0 0 Self2 0 EorI1 EorI1 Self1];
                            ID3(counter) = find(binID == classDupIDs(class));
                                                        
                        case 6
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t%d\t 0\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI1, EorI2, Self2, EorI2, Self3);
                            M3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI1 0 EorI2 Self2 EorI2 0 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t%d\t 0\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI3, EorI2, Self1, EorI1, EorI3, Self3, EorI3, Self2);
                            M3(counter,:) = [EorI1 EorI3 EorI2 Self1 EorI1 0 EorI3 Self3 EorI3 0 0 Self2];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t%d\t 0\t0\t%d\n', superClass, class, classDupIDs(class), EorI2, EorI1, EorI3, Self2, EorI2, EorI1, Self1, EorI1, Self3);
                            M3(counter,:) = [EorI2 EorI1 EorI3 Self2 EorI2 0 EorI1 Self1 EorI1 0 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t%d\t 0\t0\t%d\n', superClass, class, classDupIDs(class), EorI2, EorI3, EorI1, Self2, EorI2, EorI3, Self3, EorI3, Self1);
                            M3(counter,:) = [EorI2 EorI3 EorI1 Self2 EorI2 0 EorI3 Self3 EorI3 0 0 Self1];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t%d\t 0\t0\t%d\n', superClass, class, classDupIDs(class), EorI3, EorI1, EorI2, Self3, EorI3, EorI1, Self1, EorI1, Self2);
                            M3(counter,:) = [EorI3 EorI1 EorI2 Self3 EorI3 0 EorI1 Self1 EorI1 0 0 Self2];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t%d\t 0\t0\t%d\n', superClass, class, classDupIDs(class), EorI3, EorI2, EorI1, Self3, EorI3, EorI2, Self2, EorI2, Self1);
                            M3(counter,:) = [EorI3 EorI2 EorI1 Self3 EorI3 0 EorI2 Self2 EorI2 0 0 Self1];
                            ID3(counter) = find(binID == classDupIDs(class));
                            
                        case 7
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t%d\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI1, Self2, EorI2, EorI3, Self3);
                            M3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI1 0 0 Self2 EorI2 EorI3 0 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t%d\t %d\t0\t%d\n', superClass, class, classDupIDs(class), EorI3, EorI2, EorI1, Self3, EorI3, Self2, EorI2, EorI1, Self1);
                            M3(counter,:) = [EorI3 EorI2 EorI1 Self3 EorI3 0 0 Self2 EorI2 EorI1 0 Self1];
                            ID3(counter) = find(binID == classDupIDs(class));
                            
                        case 8
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t0\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI1, EorI2, Self2, EorI3, EorI3, Self3);
                            M3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI1 0 EorI2 Self2 0 EorI3 EorI3 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t0\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI2, EorI1, EorI3, Self2, EorI2, EorI1, Self1, EorI3, EorI3, Self3);
                            M3(counter,:) = [EorI2 EorI1 EorI3 Self2 EorI2 0 EorI1 Self1 0 EorI3 EorI3 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d,\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t0\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI3, EorI1, EorI2, Self3, EorI3, EorI1, Self1, EorI2, EorI2, Self2);
                            M3(counter,:) = [EorI3 EorI1 EorI2 Self3 EorI3 0 EorI1 Self1 0 EorI2 EorI2 Self2];
                            ID3(counter) = find(binID == classDupIDs(class));
                            
                        case 9
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t%d\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI1, EorI2, Self2, EorI2, EorI3, Self3);
                            M3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI1 0 EorI2 Self2 EorI2 0 EorI3 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t%d\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI2, EorI1, EorI3, Self2, EorI2, EorI1, Self1, EorI1, EorI3, Self3);
                            M3(counter,:) = [EorI2 EorI1 EorI3 Self2 EorI2 0 EorI1 Self1 EorI1 0 EorI3 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t%d\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI3, EorI1, EorI2, Self3, EorI3, EorI1, Self1, EorI1, EorI2, Self2);
                            M3(counter,:) = [EorI3 EorI1 EorI2 Self3 EorI3 0 EorI1 Self1 EorI1 0 EorI2 Self2];
                            ID3(counter) = find(binID == classDupIDs(class));
                            
                        case 10
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI1, EorI1, EorI2, Self2, EorI3, Self3);
                            M3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI1 EorI1 EorI2 Self2 0 0 EorI3 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI3, EorI2, Self1, EorI1, EorI1, EorI3, Self3, EorI2, Self2);
                            M3(counter,:) = [EorI1 EorI3 EorI2 Self1 EorI1 EorI1 EorI3 Self3 0 0 EorI2 Self2];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI2, EorI1, EorI3, Self2, EorI2, EorI2, EorI1, Self1, EorI3, Self3);
                            M3(counter,:) = [EorI2 EorI1 EorI3 Self2 EorI2 EorI2 EorI1 Self1 0 0 EorI3 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI2, EorI3, EorI1, Self2, EorI2, EorI2, EorI3, Self3, EorI1, Self1);
                            M3(counter,:) = [EorI2 EorI3 EorI1 Self2 EorI2 EorI2 EorI3 Self3 0 0 EorI1 Self1];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI3, EorI1, EorI2, Self3, EorI3, EorI3, EorI1, Self1, EorI2, Self2);
                            M3(counter,:) = [EorI3 EorI1 EorI2 Self3 EorI3 EorI3 EorI1 Self1 0 0 EorI2 Self2];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t 0\t%d\t%d\n', superClass, class, classDupIDs(class), EorI3, EorI2, EorI1, Self3, EorI3, EorI3, EorI2, Self2, EorI1, Self1);
                            M3(counter,:) = [EorI3 EorI2 EorI1 Self3 EorI3 EorI3 EorI2 Self2 0 0 EorI1 Self1];
                            ID3(counter) = find(binID == classDupIDs(class));
                            
                        case 11
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t 0\t%d\t0\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI1, EorI1, Self2, EorI3, EorI3, Self3);
                            M3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI1 EorI1 0 Self2 0 EorI3 EorI3 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t 0\t%d\t0\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI2, EorI1, EorI3, Self2, EorI2, EorI2, Self1, EorI3, EorI3, Self3);
                            M3(counter,:) = [EorI2 EorI1 EorI3 Self2 EorI2 EorI2 0 Self1 0 EorI3 EorI3 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t 0\t%d\t0\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI3, EorI1, EorI2, Self3, EorI3, EorI3, Self1, EorI2, EorI2, Self2);
                            M3(counter,:) = [EorI3 EorI1 EorI2 Self3 EorI3 EorI3 0 Self1 0 EorI2 EorI2 Self2];
                            ID3(counter) = find(binID == classDupIDs(class));
                            
                        case 12
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t%d\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI1, EorI2, Self2, EorI2, EorI3, EorI3, Self3);
                            M3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI1 0 EorI2 Self2 EorI2 EorI3 EorI3 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t%d\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI3, EorI2, Self1, EorI1, EorI3, Self3, EorI3, EorI2, EorI2, Self2);
                            M3(counter,:) = [EorI1 EorI3 EorI2 Self1 EorI1 0 EorI3 Self3 EorI3 EorI2 EorI2 Self2];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t%d\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI2, EorI1, EorI3, Self2, EorI2, EorI1, Self1, EorI1, EorI3, EorI3, Self3);
                            M3(counter,:) = [EorI2 EorI1 EorI3 Self2 EorI2 0 EorI1 Self1 EorI1 EorI3 EorI3 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t%d\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI2, EorI3, EorI1, Self2, EorI2, EorI3, Self3, EorI3, EorI1, EorI1, Self1);
                            M3(counter,:) = [EorI2 EorI3 EorI1 Self2 EorI2 0 EorI3 Self3 EorI3 EorI1 EorI1 Self1];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t%d\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI3, EorI1, EorI2, Self3, EorI3, EorI1, Self1, EorI1, EorI2, EorI2, Self2);
                            M3(counter,:) = [EorI3 EorI1 EorI2 Self3 EorI3 0 EorI1 Self1 EorI1 EorI2 EorI2 Self2];
                            ID3(counter) = find(binID == classDupIDs(class));
                            counter = counter+1;
                            
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t0\t %d\t%d\t%d\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI3, EorI2, EorI1, Self3, EorI3, EorI2, Self2, EorI2, EorI1, EorI1, Self1);            
                            M3(counter,:) = [EorI3 EorI2 EorI1 Self3 EorI3 0 EorI2 Self2 EorI2 EorI1 EorI1 Self1];
                            ID3(counter) = find(binID == classDupIDs(class));
                            
                        case 13
                            fprintf(fidCSV, '%d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\t %d\t%d\t%d\n', superClass, class, classDupIDs(class), EorI1, EorI2, EorI3, Self1, EorI1, EorI1, EorI2, Self2, EorI2, EorI3, EorI3, Self3);
                            M3(counter,:) = [EorI1 EorI2 EorI3 Self1 EorI1 EorI1 EorI2 Self2 EorI2 EorI3 EorI3 Self3];
                            ID3(counter) = find(binID == classDupIDs(class));
                            
                    end

                    
                    counter = counter + 1;
                    class = class + 1;

                end
            end
        end
    end
    
    save newMotif3lib M3 ID3;
    fclose(fidCSV);
end