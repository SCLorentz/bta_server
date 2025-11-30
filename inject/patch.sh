while IFS= read -r f; do
	diff -u "../server/$f" "./$f"
done < ./list.txt > server.patch