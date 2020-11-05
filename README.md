# Cub3d_destroyer - Let's Break Your Parser!

Cub3d_destroyer tries to break your cub3d parser with almost 300 different .cub files [MANDATORY PART ONLY].
The main goal of this project is to offer 42 students a tool which detects as many parsing bugs as possible for this project.
It is also an easy way to get a feeling on how your code behaves and where you can improve it.


## Disclaimer
The 42 subject lays out a big set of rules for what should be considered as valid/invalid input.
Some of these rules offer a great scope for interpretation.
While testing, I strongly advise you to take a close look on the .cub files, read the subject carefully, make up your own mind and to be always open for discussion :)!


## 	Requirements to make this test run
- Your executable should be named "cub3D". With a capital "D" just like it is stated in the subject.
- Your program has to print out "Error\n" after encountering a misconfiguration in the .cub file.


##	Step-by-Step Guide
1.	Go to the root of your cub3d directory and execute this command to clone the repo.
```
git clone https://github.com/Dustin42Codam/cub3d_destroyer.git
```
2.	cd into the cloned repo and execute the shell script
```
cd cub3d_destroyer && bash destroyer.sh
```
3.	Wait for the results!
	If the parser fails to interpret a map accordingly, the failed case will be directly printed out to stdout.
	All failed parsing attempts are also stored inside a logfile (look at screenshots below).

4.	Just add your own .cub files to the test process! It is super simple. Add all your as invalid considered files
	to the folder "invalid_maps" and the valid stuff goes of course to "valid_maps".


# Screenshots

### Output in the terminal
![cub3d_destroyer_output](https://user-images.githubusercontent.com/57137884/94357004-54564880-0095-11eb-9103-0ff36f5e74b7.png)


### Output in the logfile
![cub3d_destroyer_logfile](https://user-images.githubusercontent.com/57137884/94351607-f278ed00-005a-11eb-9e34-2d11faef3b47.png)
