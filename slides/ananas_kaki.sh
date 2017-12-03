awk 'NR==3{print "ananas"}1' fruits.txt > fruits.txt-ananas
awk 'NR==3{print "kaki"}1' fruits.txt | grep -v orange > fruits.txt-kaki
