#!/bin/bash
if ! [[ -d "tests" ]]; then
	mkdir tests
fi

cd tests

rm *.out

for f in *in; do
	../sort <"$f" >"${f%in}out" 2>/dev/null
	echo "Plik $f - $?"
done

for f in *out; do
	ogsize=$(du -s "${f%out}in" | awk '{ print $1 }')
	newsize=$(du "$f" | awk '{ print $1 }')
	if ((ogsize != newsize)); then
		echo "dla $f roznica wejscia-wyjscia"
	fi
	sort -cg <"$f" &>/dev/null 
	if (($? == 0)); then
		echo "Posortowany"
	else
		echo "Nieposortowany"
	fi
done
