import { storiesOf, addDecorator } from '@storybook/vue'
import _ from 'lodash'
import { 
  withKnobs, 
  number, 
  text, 
  boolean, 
  object,
} from '@storybook/addon-knobs'

// Simple component to test with
import Box from './Box'

// Helper for default properties

// Shared props
const props = ({
  marginTop = '100vh',
  marginBottom = '100vh',
  inViewportActive = true,
  inViewportOnce = false,
  inViewportRootMargin = undefined,
  inViewportRoot = undefined,
  inViewportThreshold = [0,1],
}) => { return {
  marginTop: { default: text('CSS margin-top', marginTop) },
  marginBottom: { default: text('CSS margin-bottom', marginBottom) },
  
  inViewportActive: { default: boolean('inViewportActive', inViewportActive) },
  inViewportOnce: { default: boolean('inViewportOnce', inViewportOnce) },
  
  inViewportRootMargin: { default: text('inViewportRootMargin', inViewportRootMargin) },
  inViewportRoot: { default: text('inViewportRoot', inViewportRoot) },
  inViewportThreshold: { default: object('inViewportThreshold', inViewportThreshold) },
}}

// Create a bucket of stories
addDecorator(withKnobs)
storiesOf('Examples', module)
  
  .add('Initially visible', () => ({
    components: { Box },
    props: props({ marginTop: '0vh' }),
    template: `<div>
      <box 
        :style='{ marginTop: marginTop, marginBottom: marginBottom  }'
        :inViewportActive='inViewportActive'
        :inViewportOnce='inViewportOnce'
        :inViewportRootMargin='inViewportRootMargin'
        :inViewportRoot='inViewportRoot'
        :inViewportThreshold='inViewportThreshold'
      />
      </div>`,
  }))
  
  .add('Scroll to reveal', () => ({
    components: { Box },
    props: props({}),
    template: `<div>
      <p>👇👇👇👇👇👇👇👇👇</p>
      <box 
        :style='{ marginTop: marginTop, marginBottom: marginBottom  }'
        :inViewportActive='inViewportActive'
        :inViewportOnce='inViewportOnce'
        :inViewportRootMargin='inViewportRootMargin'
        :inViewportRoot='inViewportRoot'
        :inViewportThreshold='inViewportThreshold'
      />
      </div>`,
  }))
  
  .add('Trigger once', () => ({
    components: { Box },
    props: props({ inViewportOnce: true }),
    template: `<div>
      <p>👇👇👇👇👇👇👇👇👇</p>
      <box 
        :style='{ marginTop: marginTop, marginBottom: marginBottom  }'
        :inViewportActive='inViewportActive'
        :inViewportOnce='inViewportOnce'
        :inViewportRootMargin='inViewportRootMargin'
        :inViewportRoot='inViewportRoot'
        :inViewportThreshold='inViewportThreshold'
      />
      </div>`,
  }))
  
  .add('Initially inactive', () => ({
    components: { Box },
    props: props({ inViewportActive: false }),
    template: `<div>
      <p>👇👇👇👇👇👇👇👇👇</p>
      <box 
        :style='{ marginTop: marginTop, marginBottom: marginBottom  }'
        :inViewportActive='inViewportActive'
        :inViewportOnce='inViewportOnce'
        :inViewportRootMargin='inViewportRootMargin'
        :inViewportRoot='inViewportRoot'
        :inViewportThreshold='inViewportThreshold'
      />
      </div>`,
  }))

