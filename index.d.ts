declare module 'vue-in-viewport-mixin' {
  import Vue from 'vue';

  export class VueInViewportMixin extends Vue {
    addInViewportHandlers(): void;
    inViewportInit(): void;
    reInitInViewportMixin(): void;
    removeInViewportHandlers(): boolean;
    updateInViewport(ioEntry: IntersectionObserverEntry): boolean;
  }

  export default VueInViewportMixin;
}
