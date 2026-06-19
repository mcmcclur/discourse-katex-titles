import { apiInitializer } from "discourse/lib/api";
import { renderKatexInElement } from "../lib/discourse-katex-titles";

const AI_CONVERSATION_LINK_SELECTOR = ".ai-conversation-sidebar__link";
const AI_CONVERSATION_TITLE_SELECTOR = `${AI_CONVERSATION_LINK_SELECTOR} .sidebar-section-link-content-text`;

function sourceKeyForTitleElement(element) {
  return (
    element.closest(AI_CONVERSATION_LINK_SELECTOR)?.getAttribute("title") ||
    element.textContent?.trim() ||
    ""
  );
}

function renderAiConversationSidebarTitles() {
  document
    .querySelectorAll(AI_CONVERSATION_TITLE_SELECTOR)
    .forEach((element) =>
      renderKatexInElement(element, sourceKeyForTitleElement(element))
    );
}

function containsAiConversationLink(node) {
  return (
    node instanceof Element &&
    (node.matches(AI_CONVERSATION_LINK_SELECTOR) ||
      node.querySelector(AI_CONVERSATION_LINK_SELECTOR))
  );
}

function mutationTouchesAiConversationLink(mutation) {
  if (
    mutation.target instanceof Element &&
    mutation.target.closest(AI_CONVERSATION_LINK_SELECTOR)
  ) {
    return true;
  }

  return Array.from(mutation.addedNodes).some(containsAiConversationLink);
}

export default apiInitializer((api) => {
  let renderScheduled = false;

  const scheduleRender = () => {
    if (renderScheduled) {
      return;
    }

    renderScheduled = true;

    window.requestAnimationFrame(() => {
      renderScheduled = false;
      renderAiConversationSidebarTitles();
    });
  };

  api.onAppEvent("discourse-ai:conversations-sidebar-updated", scheduleRender);
  api.onPageChange(scheduleRender);
  scheduleRender();

  if (!window.MutationObserver || !document.body) {
    return;
  }

  const observer = new MutationObserver((mutations) => {
    if (mutations.some(mutationTouchesAiConversationLink)) {
      scheduleRender();
    }
  });

  observer.observe(document.body, {
    attributeFilter: ["title"],
    attributes: true,
    childList: true,
    subtree: true,
  });
});
