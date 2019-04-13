// Storybook deps
import { storiesOf, addDecorator } from '@storybook/vue'
import { 
  withKnobs, 
  number, 
  text, 
  boolean, 
  object,
} from '@storybook/addon-knobs'

// Simple component to test with
import 'intersection-observer' // For IE
import Box from './Box'

// Shared props
const props = ({
  marginTop = '100vh',
  marginBottom = '100vh',
  height = '',
  inViewportActive = true,
  inViewportOnce = false,
  inViewportRootMargin = '0px 0px -1px 0px',
  inViewportThreshold = [0, 1],
}) => { return {
  marginTop: { default: text('CSS margin-top', marginTop) },
  marginBottom: { default: text('CSS margin-bottom', marginBottom) },
  height: { default: text('CSS height', height) },
  
  inViewportActive: { default: boolean('inViewportActive', inViewportActive) },
  inViewportOnce: { default: boolean('inViewportOnce', inViewportOnce) },
  
  inViewportRootMargin: { default: text('inViewportRootMargin', inViewportRootMargin) },
  inViewportThreshold: { default: object('inViewportThreshold', inViewportThreshold) },
}}

// Shared box template.  I had to make an artifical viewport box because
// I couldn't set the iframe that Storybook uses as the viewport but the
// without that, the viewport of the parent document was getting measured,
// which was too tall
// https://github.com/w3c/IntersectionObserver/issues/283
const box = `
  <div class='viewport' style='
    width: 100vw; height: 100vh;
    top: 0; left: 0;
    position: fixed;
    overflow: auto;
  '>
    <box 
      :style='{ 
        marginTop: marginTop,
        marginBottom: marginBottom,
        height: height,
      }'
      :in-viewport-active='inViewportActive'
      :in-viewport-once='inViewportOnce'
      :in-viewport-root-margin='inViewportRootMargin'
      in-viewport-root='.viewport'
      :in-viewport-threshold='inViewportThreshold'
    />
  </div>`

// Scroll down to box
const initiallyHiddenBox = `
  <div>
    <p>👇👇👇👇👇👇👇👇👇</p>
    ${box}
  </div>`

// Create a bucket of stories
addDecorator(withKnobs)
storiesOf('Examples', module)
  
  .add('Initially visible', () => ({
    components: { Box },
    props: props({ marginTop: '0vh' }),
    template: box,
  }))
  
  .add('Scroll to reveal', () => ({
    components: { Box },
    props: props({}),
    template: initiallyHiddenBox,
  }))
  
  .add('Trigger once', () => ({
    components: { Box },
    props: props({ inViewportOnce: true }),
    template: initiallyHiddenBox,
  }))
  
  .add('Initially inactive', () => ({
    components: { Box },
    props: props({ inViewportActive: false }),
    template: initiallyHiddenBox,
  }))
  
  .add('Trigger late (px)', () => ({
    components: { Box },
    props: props({ inViewportRootMargin: '-20px 0px' }),
    template: initiallyHiddenBox,
  }))
  
  .add('Trigger late (%)', () => ({
    components: { Box },
    props: props({ inViewportRootMargin: '-20% 0%' }),
    template: initiallyHiddenBox,
  }))
  
  .add('Trigger early', () => ({
    components: { Box },
    props: props({ inViewportRootMargin: '200px 0%' }),
    template: initiallyHiddenBox,
  }))
  
  .add('Full height', () => ({
    components: { Box },
    props: props({ height: 'calc(100vh + 200px)' }),
    template: initiallyHiddenBox,
  }))


