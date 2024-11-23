# **MD5 Encoder in Assembly**

This project is a simple assembly language program that demonstrates how to compute an MD5 hash for a given input string using NASM (Netwide Assembler). It leverages the external `md5sum` utility (available on most Linux systems) to perform the actual MD5 hash computation. The program is designed for educational purposes and showcases basic string manipulation and system call usage in assembly.

---

## **Features**
- Accepts a predefined string as input (`Hello, World!` in the example).
- Uses shell commands to compute the MD5 hash of the string.
- Extracts and displays the hash (32 characters) in the terminal.
- Demonstrates string concatenation, system calls, and string handling in assembly.

---

## **Requirements**
- A Linux-based system.
- NASM (Netwide Assembler) installed.
- GNU linker (`ld`) installed.
- The `md5sum` utility must be available (part of most Linux distributions).

---

## **How to Assemble and Run**
1. Clone or download the source code (`md5_encoder.asm`).
2. Assemble the program using NASM:
   ```bash
   nasm -f elf64 md5_encoder.asm -o md5_encoder.o
   ```
3. Link the object file to create the executable:
   ```bash
   ld md5_encoder.o -o md5_encoder
   ```
4. Run the program:
   ```bash
   ./md5_encoder
   ```

---

## **Output**
The program outputs the MD5 hash of the predefined input string. For the example string `Hello, World!`, the output will look like this:

```
fc3ff98e8c6a0d3087d515c0473f8677
```

---

## **Code Highlights**
1. **String Manipulation:**
   - The program concatenates strings (`echo -n`, input, and `| md5sum`) to form the shell command.
   - Demonstrates how to handle null-terminated strings in assembly.

2. **System Call Usage:**
   - The `execve` system call is used to execute the shell command and retrieve the hash.

3. **Memory Management:**
   - Uses predefined buffers and dynamically appends data without exceeding memory bounds.

---

## **Limitations**
- The program relies on the `md5sum` utility, so it is not a standalone MD5 implementation.
- It does not accept dynamic user input. The input string must be hardcoded in the source code.
- Only works on Linux systems with `md5sum` and standard syscalls.

---

## **Future Enhancements**
- Implementing the MD5 algorithm directly in assembly for a standalone solution.
- Adding dynamic user input for greater flexibility.
- Supporting other hash algorithms, such as SHA-256, by extending the logic.

---

## **Disclaimer**
This project is intended for educational purposes to help understand assembly language programming and basic system interactions. MD5 is considered cryptographically insecure for modern applications and should not be used for security-critical purposes.