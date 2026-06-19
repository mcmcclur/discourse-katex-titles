# discourse-katex-titles

## Theme summary

Uses KaTeX to typeset mathematical input in a title in a Discourse forum.

### Front page

![A front page with a typeset title](READMEImages/front-page.png)

### A topic page

![A topic page with a typeset title](READMEImages/topic.png)

### A scrolled topic page

![A scrolled topic page with a typeset title](READMEImages/topic-scrolled.png)

### AI Bot sidebar

This branch applies KaTeX to the AI Bot sidebar as well:

![KaTeXed AI Bot sidebar](READMEImages/aibot-sidebar.png)

Note, though, that getting LaTeX into the title is a bit of a trick itself. It seems that [there's no way to customize how automatic PM titles work](https://meta.discourse.org/t/automatic-and-bad-pm-conversation-titles/315909/2). To do so requires forking and editing the discourse-ai plugin itself.