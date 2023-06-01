# link and create exe

play_dice: main.o roll_dice.o count_run.o
    gcc main.o roll_dice.o count_run.o -o play_dice

# assemble

count_run.o: count_run.s
    as count_run.s -o count_run.o

main.o: main.s
    as main.s -o main.o

roll_dice.o: roll_dice.s
    as roll_dice.s -o roll_dice.o

# clean
clean:
    rm roll_dice.o main.o count_run.o