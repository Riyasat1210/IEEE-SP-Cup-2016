# IEEE-SP-Cup-2016
Location of origin detection from Media File using Multiclass SVM Classifier


****Open the "Main" folder and simply run 'Gather100' for the full program run. It will give you all the
    desired outputs.

****We also provided the app named "Classifier of Grids" but we would request you to run our 'Gather100' 
    script file instead for easy assessment.

****Training,Practice,Testing data has to be in the "setpath" for running the program.


Main Program Files included =>>>> 
1. Gather (3 Names)     => Gathers Data From each Folder, Loads Files and Creates a Mother Matrix 	
2. SplitterNew   => Splits data into 10 min segments
3. ProcessorFinal  => Main STFT and Feature Extractor. 


Specific Purpose Scripts =>>> (Not Required)
1. Filter Creator  => Generates the Filter required
2. Shifter_decimte => For Shifting and Scaling Higher Harmonics
3. Frequency       => Determines whether File contains 50Hz or 60Hz signal
4. Shifter_SNRCH   => SNR calculation
5. AudioPowerDetect => Detects audio and power among practice data.
6. AudioPowerDetect100=> Detects audio and power among  test data.


***************************** PROCEDURE *****************************************

FOR TRAINING WHOLE PROGRAM WITH DATA AND CHECKING

1. Run the script named 'Gather100'. It will train the Classification System and output two Labels. PracticeLABEL and TestLABEL. 
   These are the Labels for testing and training datasets. The Outputs, that we have shown in the report changes by
   one or two examples from time to time.

   The Functions PNormal and ANormal outputs the LABEL of the practice and test recordings.



2.      In Case the Program Fails to work as it should, Run 'Gather_Practice' and save Variables
	Audio_Feat, Power_Feat, Practice_Feat. These files contain the feature arrays for
	Audio, Power and Practice. This should also output the Practice Data sequence.
	 

	After that run 'Gather_test' while keeping the above three variables saved in the workspace. 
	This will output the TEST Data sequence.

**** 3. For Fast Result Testing we have provided  another folder named "Fast Result Testing", Run the Script named "TestPracticeResult".
	We have already collected and trained our system on the Training Recordings, and also extracted features from Practice and Test
	recordings and save them in the "Submission_Features.mat" file. Run this script to get a quick confirmation of our results. 

