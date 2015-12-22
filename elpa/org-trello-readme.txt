Minor mode to sync org-mode buffer and trello board

1) Add the following to your Emacs init file
(require 'org-trello)
(add-hook 'org-mode-hook 'org-trello-mode)

2) Once - Install the consumer-key and read/write token for org-trello to work in your name with your boards (C-c o i)
M-x org-trello/install-key-and-token

You may want:
- to connect your org buffer to an existing board (C-c o I).  Beware that this will only install properties needed to speak with trello board (nothing else).
M-x org-trello/install-board-and-lists-ids

- to create an empty board directly from a org-mode buffer (C-c o b)
M-x org-trello/create-board

3) Now check your setup is ok (C-c o d)
M-x org-trello/check-setup

6) For some more help (C-c o h)
M-x org-trello/help-describing-setup

7) If you attached to an existing trello board, you may want to bootstrap your org-buffer (C-u C-c o s)
C-u M-x org-trello/sync-buffer

Now you can work with trello from the comfort of org-mode and Emacs
8) Sync an entity from org to trello (C-c o c)
M-x org-trello/sync-entity

9) Sync an entity and its structure from org to trello (C-c o C)
M-x org-trello/sync-full-entity

10) Sync an entity from trello to org (C-u C-c o c)
C-u M-x org-trello/sync-entity

11) Sync an entity and its structure from trello to org (C-u C-c o C)
C-u M-x org-trello/sync-full-entity

12) Sync all the org buffer to trello (C-c o s)
M-x org-trello/sync-buffer

13) As already mentionned, you can sync all the org buffer from trello (C-u C-c o s)
C-u M-x org-trello/sync-buffer

Enjoy!

More informations on https://org-trello.github.io/org-trello
