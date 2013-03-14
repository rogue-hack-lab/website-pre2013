name 'wiki'
description 'rogue hack lab wiki server'
run_list 'recipe[sshd]', 'recipe[packages]', 'recipe[wiki]'
