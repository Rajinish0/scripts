## GCD OF TWO NUMS
## tried extrapolating my knowledge of recursion to scripts
## if a function can call itself, so can a script probably.
## and this works alright
#im not checking for which one is greater because they get swapped if the second one is greater than the first one in 
## the recursion step


if [ $(($1 % $2)) = 0 ]
then
	echo $2
else 
	bash practice8.sh $2 $(($1 % $2))
fi


