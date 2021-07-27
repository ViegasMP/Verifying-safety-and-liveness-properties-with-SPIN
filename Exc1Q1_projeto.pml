bool turn , flag [2];
int n_proc=0;

active [2] proctype P ()
{

	non_cs :
		flag [ _pid ] = 1; 			/* wants to enter critical section */

		turn = 1 - _pid ; 			/* politely give turn to the other one */

		(! flag [1 - _pid ] || turn == _pid ); 	/* block until the other doesn ’ t want */
							/* OR it is this one ’ s turn */
		n_proc++;		
	cs :
		assert(n_proc==1)
		skip ; /* critical section */

	exit :
		n_proc--;
		flag [ _pid ] = 0; /* leaves the critical section */
		goto non_cs
}