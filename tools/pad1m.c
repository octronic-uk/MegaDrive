#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

/* 
 * 1st parameter: a file name. 
 * 2nd parameter: a file size. 
 */

#define ONE_MEG 1048576
#define MIN_ARGS 2

int 
main
(int argc, char ** args) 
{
    if (argc < MIN_ARGS)
    {
        printf("Invalid Arguments.\n\t1: a file name.\n"); //\t2: a file size.\n");
        return 1;
    }

    int inputFileDescriptor = open(args[1], O_WRONLY);
    int outputFileSize = ONE_MEG; //atoi(args[2])-1;
    int inputFileSize = lseek(inputFileDescriptor, 0, SEEK_END);
    write(inputFileDescriptor, "\0", 1);

    //lseek(inputFileDescriptor, outputFileSize, SEEK_SET);
    int bytesToWrite = outputFileSize-inputFileSize;

    printf("File size of %d, padding with %d bytes\n",inputFileSize,bytesToWrite);
    
    int i;
    for (i=0;i<bytesToWrite;i++)
    {
        write(inputFileDescriptor, "\0", 1);
    }

    close(inputFileDescriptor);
    return 0;
}
