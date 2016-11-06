import vim

def vsh_insert_text(data, insert_buf):
    '''
    Insert text into a vsh buffer in the correct place.
    Don't modify the user state and don't interrupt their workflow.

    '''
    try:
        vsh_buf = vim.buffers[int(insert_buf)]
    except KeyError:
        vim.command('echoerr "Vsh text recieved for invalid buffer"')
        return

    active_prompt, _ = vsh_buf.mark('d')
    prompt = vsh_buf.vars['prompt']
    # The mark is returned as line position how vim sees it, so indexing into
    # the python buffer object with that position returns the line *after* the
    # active prompt.

    for (count, line) in enumerate(vsh_buf[active_prompt:]):
        # Want to use vim match() so that if we decide to allow regexp prompts
        # in the future the match will behave like vim.
        # Reading the help pages, I would use the vim.Funcref() constructor and
        # work with the vim function inside python, but this object isn't
        # foundu in the neovim client.
        if line.startswith(prompt):
            break

    # append() adds a line after the Vim line number given in the argument.
    # active_prompt is the Vim line number of the active prompt
    # There are 'count' lines between the active prompt and the next one.
    vsh_buf.append(data, active_prompt + count)

