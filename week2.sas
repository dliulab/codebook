LIBNAME mydata "/courses/d1406ae5ba27fe300" access=readonly;

DATA new; set mydata.OLL_pds;
LABEL	W1_A5A="Who did you vote for?"
		W1_A5B="Who would you have voted for?"
		W1_C1="Do you think of yourself as a Democrat, Republican, Independent, or something else?"
		PPETHM="Race / Ethnicity"
		PPINCIMP="Household Income"
		PPEDUCAT="Education (Categorical)"
		PPRENT="Ownership Status of Living Quarters"
		;
PROC SORT; 
		by CASEID;
PROC FORMAT;
		VALUE 
			W1_A5A 1='John McCain' 2='Barack Obama' 3='Other' -1='Refused'
		;
		VALUE
			W1_A5B 1='John McCain' 2='Barack Obama' 3='Other' 4='No one/Refused to vote' 
					-1='Refused'
		;
		VALUE
			W1_C1_ 1='Republican' 2='Democrat' 3='Independent' 4='Something else' -1='Refused'
		;
		VALUE
			PPETHM 1='White, Non-Hispanic' 2='Black, Non-Hispanic' 3='Other, Non-Hispanic' 
					4='Hispanic' 5='2+ Races, Non-Hispanic'
		;
		VALUE
			PPINCIMP 
				 1='Less than $5,000' 
				 2='$5,000 to $7,499'
				 3='$7,500 to $9,999'
				 4='$10,000 to $12,499'
				 5='$12,500 to $14,999'
				 6='$15,000 to $19,999'
				 7='$20,000 to $24,999'
				 8='$25,000 to $29,999'
				 9='$30,000 to $34,999'
				10='$35,000 to $39,999'
				11='$40,000 to $49,999'
				12='$50,000 to $59,999'
				13='$60,000 to $74,999'
				14='$75,000 to $84,999'
				15='$85,000 to $99,999'
				16='$100,000 to $124,999'
				17='$125,000 to $149,999'
				18='$150,000 to $174,999'
				19='$175,000 or more'
		;
		VALUE
			PPEDUCAT
				1='Less than high school'
				2='High school'
				3='Some college'
				4='Bachelor''s degree or higher'
		;
		VALUE
			PPRENT
				1='Owned'
				2='Rented'
				3='Occupied without rent'
		;
PROC FREQ; 
		TABLES W1_A5A W1_A5B W1_C1 PPETHM PPINCIMP PPEDUCAT PPRENT
		;
		FORMAT 
			W1_A5A W1_A5A.
			W1_A5B W1_A5B.
			W1_C1 W1_C1_.
			PPETHM PPETHM.
			PPINCIMP PPINCIMP.
			PPEDUCAT PPEDUCAT.
			PPRENT PPRENT.
		;
PROC FREQ;
	TITLE 'Race v. Candidate voted';
	TABLES PPETHM*W1_A5A;
	FORMAT 
			W1_A5A W1_A5A.
			PPETHM PPETHM.
	;		
PROC FREQ;
	TITLE 'Household Income v. Candidate voted';
	TABLES PPINCIMP*W1_A5A;
	FORMAT 
			W1_A5A W1_A5A.
			PPINCIMP PPINCIMP.
	;
PROC FREQ;
	TITLE 'Education v. Candidate voted';
	TABLES PPEDUCAT*W1_A5A;
	FORMAT 
			W1_A5A W1_A5A.
			PPEDUCAT PPEDUCAT.
	;
PROC FREQ;
	TITLE 'Ownership status v. Candidate voted';
	TABLES PPRENT*W1_A5A;
	FORMAT 
			W1_A5A W1_A5A.
			PPRENT PPRENT.
	;
RUN;