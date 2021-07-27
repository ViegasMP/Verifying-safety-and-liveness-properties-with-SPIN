#define N 5

int forks[N]=0;

active [N] proctype Phil () {
	int fork_num;
	int fork_num2;
	do
		:: printf (" philosopher %d thinks ...\n " , _pid );

		/* pick up forks if available */

		/*Escolhe o garfo da esquerda*/
		atomic{fork_num=_pid;}

		do
	     	::atomic{forks[fork_num]>0 -> skip;}
	     	::atomic{else -> forks[fork_num] = forks[fork_num] + 1; break;}
		od;
	
		/*Escolhe o garfo da direita*/
		atomic{
			if
			::_pid==N-1 -> fork_num2=0;
			::else -> fork_num2=_pid+1;
			fi;
		}

		do
	     	::atomic{forks[fork_num2]>0 -> skip;}
	     	::atomic{else -> forks[fork_num2] = forks[fork_num2] + 1;break;}
		od;
	
		printf (" philosopher %d eats using forks %d and %d\n" , _pid, fork_num, fork_num2 );

		/* put the two forks down */

		/*Libera o garfo da esquerda*/
		atomic{forks[fork_num] = forks[fork_num]-1;}
	

		/*Libera o garfo da direita*/
		atomic{forks[fork_num2] = forks[fork_num2]-1;}

	od
}
