#define N 5

int forks[N]=0;

active [N] proctype Phil () {
	int fork_num;
	int fork_num2;
	do
		:: printf (" philosopher %d thinks ...\n " , _pid );

		/* pick up forks if available */

		/*Escolhe o garfo da esquerda*/
		fork_num=_pid;
		
		forks[fork_num] = forks[fork_num] + 1;

		/*Assert exc5*/
		assert(forks[fork_num] <= 1)
	
		/*Escolhe o garfo da direita*/
		if
			::_pid==N-1 -> fork_num2=0;
			::else -> fork_num2=_pid+1;
		fi;

		forks[fork_num2] = forks[fork_num2]+1;

		/*Assert exc5*/
		assert(forks[fork_num2] <= 1)
	
		printf (" philosopher %d eats using forks %d and %d\n" , _pid, fork_num, fork_num2 );

		/* put the two forks down */

		/*Libera o garfo da esquerda*/
		forks[fork_num] = forks[fork_num]-1;
	

		/*Libera o garfo da direita*/
		forks[fork_num2] = forks[fork_num2]-1;

	od
}
