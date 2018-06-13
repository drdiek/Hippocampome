def select_processing_option(supertypesRawDataFrame):
    from lib.preprocess_supertypes_fuzzy_morphology_data import preprocess_fuzzy_morphology_data
#    from lib.plot_fuzzy_morphology import plot_fuzzy_morphology_matrix
#    from lib.preprocess_fuzzy_markers import preprocess_fuzzy_markers_data
#    from lib.plot_fuzzy_markers import plot_fuzzy_markers_matrix
    
    reply = ''
    
    # main loop to display menu choices and accept input
    # terminates when user chooses to exit
    while (not reply):
    
        try:
            print("\033c"); # clear screen
                
            ## display menu ##
            print 'Please select your processing option from the selections below:\n'
                
            print '    1) Plot "fuzzy" morphology matrix by types'
            
            print '    2) Plot "fuzzy" morphology matrix by supertypes'
            
            print '    3) Plot "fuzzy" morphology matrix by superfamilies'
            
            print '    4) Plot "fuzzy" markers matrix'
            
            print '    !) Exit'

            reply = raw_input('\nYour selection: ')
                
            ## process input ##
            if reply == '!':
                return('!')
            else:
                print reply
                reply = int(reply)
                print reply
                if reply == 1:
                    print 56
                    isPlotSupertypesOnly = 0
                    print 12
                    isPlotSuperfamiliesOnly = 0
                    print 89
                    morphologyDataFrame,infoDataFrame = preprocess_fuzzy_morphology_data(supertypesRawDataFrame,isPlotSupertypesOnly,isPlotSuperfamiliesOnly)
    #                plot_fuzzy_morphology_matrix(morphologyDataFrame,infoDataFrame,supertypesRawDataFrame,isPlotSupertypesOnly,isPlotSuperfamiliesOnly)
                    print 23
                    reply = ''
                elif reply == 2:
                    isPlotSupertypesOnly = 1
                    isPlotSuperfamiliesOnly = 0
                    morphologyDataFrame,infoDataFrame = preprocess_fuzzy_morphology_data(supertypesRawDataFrame,isPlotSupertypesOnly,isPlotSuperfamiliesOnly)
    #                plot_fuzzy_morphology_matrix(morphologyDataFrame,infoDataFrame,supertypesRawDataFrame,isPlotSupertypesOnly,isPlotSuperfamiliesOnly)
                    reply = ''
                elif reply == 3:
                    isPlotSupertypesOnly = 0
                    isPlotSuperfamiliesOnly = 1
                    morphologyDataFrame,infoDataFrame = preprocess_fuzzy_morphology_data(supertypesRawDataFrame,isPlotSupertypesOnly,isPlotSuperfamiliesOnly)
    #                plot_fuzzy_morphology_matrix(morphologyDataFrame,infoDataFrame,supertypesRawDataFrame,isPlotSupertypesOnly,isPlotSuperfamiliesOnly)
                    reply = ''
                elif reply == 4:
    #                markersDataFrame = preprocess_fuzzy_markers_data(supertypesRawDataFrame)
    #                plot_fuzzy_markers_matrix(markersDataFrame)
                    reply = ''
                else:
                    reply = ''
                
        except ValueError:
            print 'Oops! That was not a valid number. Please try again ...'
