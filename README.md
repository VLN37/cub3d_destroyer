# cub3d_destroyer - Let's Break Your Parser!

cub3d_destroyer tries to break your cub3d parser with almost 300 different .cub files.
Get ready... only the best ones will survive!

## Disclaimer
The 42 subject lays out a big set of rules for what should be considered as valid/invalid input.
Some of these rules offer a great scope for interpretation.
While testing, I strongly advise you to take a close look on the .cub files and to be always open for discussion.


## Requirements to make this test run
- Your executable should be named "cub3D". With a capital "D" just like it is stated in the subject.
- Your program/parser has to print out "Error\n" after encountering a misconfiguration in the .cub file.


## Step-by-Step Guide
1. Use this command to clone the repository to the root directory of your cub3d project.
```
git clone https://github.com/Dustin42Codam/cub3d_destroyer.git
```
2. Execute the shell script
```
bash destroyer.sh
```
3. Wait for the results!
   When your parser will fail, you will see the results directly in the terminal.
   All your failed parsing attempts will be also stored inside a logfile ("damage_report.log").


# Screenshots

### Output in the terminal
![cub3d_destroyer_output](https://user-images.githubusercontent.com/57137884/94350780-066c2100-0052-11eb-8f34-4db5e2544a4d.png)


### Output in the logfile
![cub3d_destroyer_logfile](https://user-images.githubusercontent.com/57137884/94351607-f278ed00-005a-11eb-9e34-2d11faef3b47.png)
