#!/bin/bash

[ ! -z "${1}" ] && infile="${1}" || infile="t1b_path_planner.c"

ARCH=rv32i
ROM=2048
RAM=256
STACK=64

CFLAGS="  -march=$ARCH -mabi=ilp32 --specs=picolibc.specs -Os -g3 -flto -DPICOLIBC_INTEGER_PRINTF_SCANF -Wall"
LDFLAGS=" -march=$ARCH -mabi=ilp32 --specs=picolibc.specs -Os -g3 -flto -DPICOLIBC_INTEGER_PRINTF_SCANF "
LDFLAGS+=" -Wl,--gc-sections,--defsym=__flash=0x00000000,--defsym=__flash_size=$ROM --crt0=minimal" #" -nostartfiles"
LDFLAGS+=" -Wl,--defsym=__ram=0x02000000,--defsym=__ram_size=$RAM,--defsym=__stack_size=$STACK -Tpicolibc.ld"

cd ../

riscv64-unknown-elf-gcc $CFLAGS -c "path_planner_c/$infile" -o .temp.file.o && \
riscv64-unknown-elf-gcc $LDFLAGS -o .temp.file.elf .temp.file.o && \
riscv64-unknown-elf-objdump --visualize-jumps -t -S --source-comment='     ### ' .temp.file.elf -M no-aliases,numeric > machine_code.lss && \
riscv64-unknown-elf-objcopy -O binary .temp.file.elf .temp.file.bin && \
truncate -s $ROM .temp.file.bin && \
riscv64-unknown-elf-objcopy --verilog-data-width=4 --reverse-bytes=4 -I binary -O verilog .temp.file.bin program_dump.hex && \
riscv64-unknown-elf-size -B --common .temp.file.elf && \

echo "program_dump.hex and machine_code.lss have been successfully generated from $infile"  || \
echo "And therefore, $infile could not be converted into binary format. :("

rm -f .temp.file.*
