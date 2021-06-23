#!/bin/bash
c=1
while [ $c -le 5 ]
do
  curl -LI www.google.com
	(( c++ ))
done
