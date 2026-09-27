#!/bin/bash
set -euo pipefail

PROJECT_DIR="/tmp/project"

echo "Creating directory structure..."
mkdir -p "${PROJECT_DIR}"/{data,scripts,logs,backup}

echo "Creating files in the 'data' directory..."
for i in 1 2 3 4 5; do
    echo "This is sample content for file${i}" > "${PROJECT_DIR}/data/file${i}.txt"
done

echo "Copying 'file1.txt' to 'backup' directory..."
cp "${PROJECT_DIR}/data/file1.txt" "${PROJECT_DIR}/backup/"

echo "Renaming 'file3.txt' to 'file3_renamed.txt'..."
mv "${PROJECT_DIR}/data/file3.txt" "${PROJECT_DIR}/data/file3_renamed.txt"

echo "Moving 'file4.txt' and 'file5.txt' to 'logs' directory..."
mv -f "${PROJECT_DIR}/data/file4.txt" "${PROJECT_DIR}/data/file5.txt" "${PROJECT_DIR}/logs/"

echo "Deleting 'file2.txt' from 'data' directory..."
rm -f "${PROJECT_DIR}/data/file2.txt"

echo "Listing all files and directories with detailed information..."
ls -laR "${PROJECT_DIR}"

echo "Displaying total size of 'data' and 'logs' directories..."
du -sh "${PROJECT_DIR}/data" "${PROJECT_DIR}/logs"

echo "Displaying the 10 largest files and directories in 'project'..."
du -ah "${PROJECT_DIR}" | sort -rh | head -10

echo "Setting file permissions 644 for 'file1.txt'..."
chmod 644 "${PROJECT_DIR}/backup/file1.txt"

echo "Setting file permissions 644 for 'file3_renamed.txt'..."
chmod 644 "${PROJECT_DIR}/data/file3_renamed.txt"

echo "Changing ownership of 'file4.txt'..."
sudo chown nobody:nogroup "${PROJECT_DIR}/logs/file4.txt"

echo "Creating symbolic link 'file1_link.txt' in 'scripts' directory..."
ln -s ../backup/file1.txt "${PROJECT_DIR}/scripts/file1_link.txt"

echo "Verifying the symbolic link of file1.txt..."
ls -la "${PROJECT_DIR}/scripts/file1_link.txt"
readlink "${PROJECT_DIR}/scripts/file1_link.txt"

echo "Displaying disk usage of the filesystem..."
df -h

echo "Listing all running processes and finding PID of 'bash'..."
ps aux | grep bash

echo "Creating a compressed archive of the 'backup' directory..."
tar -czf "${PROJECT_DIR}/backup/backup_$(date +%Y%m%d).tar.gz" -C "${PROJECT_DIR}" backup

echo "Logging completion message..."
echo "Lab 1 completed successfully on $(date)" > "${PROJECT_DIR}/README.md"

echo "Verifying final directory state..."
if [ ! -d "${PROJECT_DIR}/data" ]; then
    echo "Error: ${PROJECT_DIR}/data does not exist!" >&2
    exit 1
fi

echo "Lab 1 script finished successfully."
