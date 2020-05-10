# Semester Changer
## What is this?
This is a batch program that is meant to be run at startup that utilizes a specific folder stucture and automatically makes changes when the semester changes. Semesters are based on the trimester system of Fall, Winter, and Summer semesters. Summer is considered the last semester in the academic year.

The program was develped in the context of Canadian universities as of the year 2020 which mostly operate under the trimester system of Fall being from Sep-Dec, Winter being Jan-Apl, and Summer being from May-Aug. This is modifiable within the source code if your school is different.

This program also relies on the idea that you restart your computer every day, as it checks once at startup. If you are someone who leaves their computer on for weeks or months (or years!) at a time, you will need to figure out a way to check somehow once a day by either manually running it, or figuring out a way to run it once a day.

## Folder Structure
By default the ROOT folder is set to `C:\Users\USERNAME\Documents\Personal Documents\School Documents` but this can be whatever you want. See **Changing the Root Folder** on how to change this.

From here, the structure is as follows:
```
ROOT
 ├── Current Semester
 ├── 2019-2020
 │    ├── Fall
 |    ├── Winter
 |    └── Summer
 ├── 2020-2021
 │    ├── Fall
 |    ├── Winter
 |    └── Summer
 ├── 2021-2022
 │    ├── Fall
 |    ├── Winter
 |    └── Summer
 └── 2022-2023
      ├── Fall
      ├── Winter
      └── Summer
```
Follow this exactly and the program should work as intended. Otherwise, modification to the source code will be required.

The actual program itself can be stored anywhere you'd like, however you will need to place a link to `change_icon.bat` in the folder 
```
C:\Users\USER\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
```
You can navigate to this folder by using the run dialog and typing `shell:startup` and it should bring you to it. The reason this is required is because the program runs everytime you start your computer, without this you will need to either manually run it or use a different automatic method.

## Changing the Root Folder
Under line 15, you specify the ROOT of where your folder structure will be.
```
set "class_folders_root=%userprofile%\Documents\Personal Documents\School Documents"
```
Change this to wherever you'd like.

## Changes the Program Makes
This program does three things:
1. Changes the icon of `Current Semester` to the appropriate icon for the new semester
2. When the program detects a semester change, it moves the contents from `Current Semester` to whatever the now last semester was
3. It then moves contents of the now current semester into the `Current Semester` folder

If the process occurs a **dialog** box will appear notifying you of the changes showing the following: 
```
The current semester has changed. The following has updated:

<> Last semester files have been moved from the Current Term folder to their original destination. 
<> Current semester files have been moved to your Current Term folder. 
<> The Icon has been updated accordingly.

Press any key to continue . . .
```
Otherwise if the semester has not changed, nothing will appear.

### An Example
Lets say today is April 20th 2022. The `Current Semester` folder currently contains everything within `2021-2022\Winter` and the icon is a snowflake. Some time passes and it is now May 1st 2022. The icon on `Current Semester` is changed to a sun, and everything within `Current Semester` is moved back into the empty `2021-2022\Winter` folder. As it is now the summer semester, everything contained within `2021-2022\Summer` is moved into `Current Semester`. The **dialog** box will appear.
















