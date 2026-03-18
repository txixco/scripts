md5=$(echo -n $1 | md5sum | awk '{print $1}')
echo "flag{$md5}" | tee >(tr -d "\n" | xclip -selection clipboard)
