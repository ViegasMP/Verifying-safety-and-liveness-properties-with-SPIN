#define N 5

int forks[N]=0;

active [N] proctype Phil () {
	int fork_num;
	int fork_num2;
	do
		:: printf("philosopher %d will think again\n", _pid); skip;
		:: printf (" philosopher %d thinks ...\n " , _pid );

		/* Verifica qual garfo tem de escolher primeiro */
		if
		::_pid==N-1 -> goto right;
		::else -> goto left;
		fi;

		left:
			/*Escolhe o garfo da esquerda*/
			atomic{fork_num=_pid;}


			do
		     	::atomic{forks[fork_num]>0 -> printf("im philosopher %d , waiting for fork n: %d being used by %d other philosopher\n",_pid,fork_num,forks[fork_num] );skip;}
		     	::atomic{else ->forks[fork_num] = forks[fork_num] + 1; printf("im philosopher %d and grabbed fork n: %d\n",_pid,fork_num);break;}
			od;

			assert(forks[fork_num] <= 1);
			
			if
			::_pid==N-1 -> goto eat;
			::else -> goto right;
			fi;
	
		/*Escolhe o garfo da direita*/
	     	right:
			atomic{
				if
				::_pid==N-1 -> fork_num2=0;
				::else -> fork_num2=_pid+1;
				fi;
			}

			do
		     	::atomic{forks[fork_num2]>0 -> printf("im philosopher %d , waiting for fork n: %d being used by %d other philosopher\n",_pid,fork_num2,forks[fork_num2] );skip;}
		     	::atomic{else ->forks[fork_num2] = forks[fork_num2] + 1; printf("im philosopher %d and grabbed fork n: %d\n",_pid,fork_num2);break;}
			od;

			assert(forks[fork_num2] <= 1);

			if
			::_pid==N-1 -> goto left;
			::else -> goto eat;
			fi;

		eat:
			printf (" philosopher %d eats using forks %d and %d\n" , _pid, fork_num, fork_num2 );


		/* put the two forks down */
		free:
	
			/*Libertar primeiro esquerda*/
			atomic{forks[fork_num] = forks[fork_num]-1;}

			/*LIbertar segundo direita*/		
			atomic{forks[fork_num2] = forks[fork_num2]-1;}
		

	od
}