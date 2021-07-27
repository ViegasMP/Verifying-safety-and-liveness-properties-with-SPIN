bool turn , flag [2];
int s=20;

inline wait() {
	atomic{ s>0 ; s--}
}

active [2] proctype P ()
{

	non_cs :

		do
		:: wait() -> printf("I am pid: %d and I will wait\n", _pid)
		:: break
		od


		flag [ _pid ] = 1; 			/* wants to enter critical section */

		turn = 1 - _pid ; 			/* politely give turn to the other one */

		(! flag [1 - _pid ] || turn == _pid ); 	/* block until the other doesn ’ t want */
							/* OR it is this one ’ s turn */


	cs :
		skip ; /* critical section */


	exit :
		flag [ _pid ] = 0; /* leaves the critical section */
		goto non_cs
}