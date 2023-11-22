#!/bin/bash
pwd
ls

echo "This program made by Yurikov Andrey Anatolyevich in group 710-1"
echo "This program deletes files larger than a specified value"

echo "Please enter the directory path:"
read -r directory_path

if [ ! -d "$directory_path" ]; then
echo "Directory does not exist. Please enter a valid directory." >&2
exit 1
fi

echo "Please enter the file size in KB:"
read -r file_size

if ! [[ "$file_size" =~ ^[0-9]+$ ]]; then
echo "Invalid file size. Please enter a numeric value." >&2
exit 1
fi

large_files=$(find "$directory_path" -type f -size +"${file_size}k")

if [ -z "$large_files" ]; then
echo "No files larger than $file_size KB were found in $directory_path."
exit 0
fi

echo "The following files are larger than $file_size KB:"
echo "$large_files"

echo "Do you want to delete these files? yes/no"
read -r confirm
case $confirm in
[yY][eE][sS]|[yY])
echo "$large_files" | xargs rm -f && echo "File(s) were deleted"
ls
;;
[nN][oO]|[nN])
echo "Deletion cancelled."
;;
*)
echo "Invalid choice. Deletion cancelled." >&2
;;
esac