SRCS = $(wildcard *.s)
OBJS = $(patsubst %.s,%.o,$(SRCS))
ASFLAGS = --gstabs
out = main.bin

$(out): $(OBJS)
	$(CC) -o $@ $^

clean:
	rm *.o $(out)