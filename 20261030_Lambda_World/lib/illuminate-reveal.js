// @ts-check

// Shared animation helpers used by standalone.js, reveal.js, and animate_widget.js.
// Defined as var declarations so they work when concatenated before any player.

/**
 * Finds the segment containing the given frame index.
 * @param {Segment[]} segments
 * @param {number} frame
 * @returns {Segment}
 */
var animFindSegment = function (segments, frame) {
    for (var i = 0; i < segments.length; i++) {
        var s = segments[i];
        if (frame >= s.sf && frame < s.sf + s.fc) return s;
    }
    return segments[segments.length - 1];
};

/**
 * Returns the index of the step active at the given frame.
 * @param {StepInfo[]} steps
 * @param {number} frame
 * @returns {number}
 */
var animFindCurrentStep = function (steps, frame) {
    for (var i = steps.length - 1; i >= 0; i--) {
        if (frame >= steps[i].frame) return i;
    }
    return 0;
};

/**
 * Clamps a frame index to `[0, totalFrames - 1]`.
 * @param {number} frame
 * @param {number} totalFrames
 * @returns {number}
 */
var animClampFrame = function (frame, totalFrames) {
    return Math.max(0, Math.min(frame, totalFrames - 1));
};

/**
 * Computes a frame index from an elapsed-time measurement.
 * @param {number} startTime - timestamp when playback began
 * @param {number} timestamp - current requestAnimationFrame timestamp
 * @param {number} fps - frames per second
 * @param {number} pauseFrame - frame offset at which playback started
 * @returns {number}
 */
var animComputeFrame = function (startTime, timestamp, fps, pauseFrame) {
    var elapsed = (timestamp - startTime) / 1000;
    return pauseFrame + Math.round(elapsed * fps);
};

/**
 * Returns the frame index where the step at `stepIndex` ends.
 * @param {StepInfo[]} steps
 * @param {number} stepIndex
 * @param {number} totalFrames
 * @returns {number}
 */
var animFindStepEnd = function (steps, stepIndex, totalFrames) {
    return stepIndex + 1 < steps.length ? steps[stepIndex + 1].frame : totalFrames;
};

/**
 * @typedef {{ wrapped: number, didCycle: boolean }} LoopResult
 */

/**
 * Wraps a frame within a looping step's range. Returns the wrapped frame
 * and whether a full cycle boundary was crossed.
 * @param {number} frame
 * @param {number} stepStart
 * @param {number} stepEnd
 * @returns {LoopResult}
 */
var animWrapLoop = function (frame, stepStart, stepEnd) {
    var stepLen = stepEnd - stepStart;
    if (stepLen <= 0 || frame < stepEnd) return { wrapped: frame, didCycle: false };
    var overshoot = (frame - stepStart) % stepLen;
    return { wrapped: stepStart + overshoot, didCycle: true };
};

/**
 * Scans forward from `currentStep` to check if any pause steps have been
 * crossed at the given frame. Returns the first pause found, or null.
 * @param {StepInfo[]} steps
 * @param {number} currentStep
 * @param {number} frame
 * @returns {{ pauseAtStep: number, pauseAtFrame: number } | null}
 */
var animCheckPauseSteps = function (steps, currentStep, frame) {
    var step = animFindCurrentStep(steps, frame);
    if (step > currentStep) {
        for (var s = currentStep + 1; s <= step; s++) {
            if (steps[s].pause) {
                return { pauseAtStep: s, pauseAtFrame: steps[s].frame };
            }
        }
    }
    return null;
};

/**
 * Indexes patchable SVG elements by their `data-e` attribute.
 *
 * The Lean SVG renderer tags each element that produces a DOM node with
 * `data-e="N"` where N is the element index used by paramMap. This
 * function collects those elements into a sparse array keyed by N,
 * decoupling the JS side from any particular DOM walk order.
 * @param {HTMLElement} container
 * @returns {Element[]}
 */
var animIndexElements = function (container) {
    /** @type {Element[]} */
    var elems = [];
    var tagged = container.querySelectorAll("[data-e]");
    for (var i = 0; i < tagged.length; i++) {
        var el = tagged[i];
        var idx = parseInt(el.getAttribute("data-e") || "0", 10);
        elems[idx] = el;
    }
    return elems;
};

/**
 * Renders a frame into a container using parameterized attribute updates
 * when available, falling back to full SVG replacement.
 * Returns the segment used (for callers that track the current segment).
 * @param {HTMLElement} container
 * @param {Segment} seg
 * @param {Segment | null} currentSeg - the previously rendered segment (for change detection)
 * @param {number} local - frame index within the segment
 * @returns {Segment} the segment (with `_elems` populated)
 */
var animRenderSegFrame = function (container, seg, currentSeg, local) {
    if (seg !== currentSeg) {
        container.innerHTML = seg.sync;
        seg._elems = animIndexElements(container);
    }
    if (seg._elems && seg.pmap && seg.params && seg.params[local]) {
        var p = seg.params[local];
        for (var i = 0; i < seg.pmap.length; i++) {
            var binding = seg.pmap[i];
            var elem = seg._elems[binding.e];
            if (elem && p[i] !== undefined) {
                if (binding.a === "textContent") {
                    elem.textContent = p[i];
                } else {
                    elem.setAttribute(binding.a, p[i]);
                }
            }
        }
    }
    return seg;
};

// @ts-check

// Multi-animation reveal.js integration for VersoSlides.
// anim_core.js helpers (animFindSegment, animRenderSegFrame, etc.)
// are prepended by the Lean build via include_str concatenation.

(function () {
    /** @type {Object<string, {data: AnimData, container: HTMLElement, currentSeg: Segment | null, currentFrame: number, animId: number | null, pauseSteps: StepInfo[]}>} */
    var animations = {};

    /**
     * @param {{data: AnimData, container: HTMLElement, currentSeg: Segment | null, currentFrame: number}} state
     * @param {number} frame
     */
    function showFrame(state, frame) {
        frame = animClampFrame(frame, state.data.totalFrames);
        state.currentSeg = animRenderSegFrame(
            state.container,
            animFindSegment(state.data.segments, frame),
            state.currentSeg,
            frame - animFindSegment(state.data.segments, frame).sf,
        );
        state.currentFrame = frame;
    }

    var scripts = document.querySelectorAll("script[data-illuminate-anim]");
    for (var si = 0; si < scripts.length; si++) {
        var scriptEl = scripts[si];
        var containerId = scriptEl.getAttribute("data-illuminate-anim");
        if (!containerId) continue;
        var container = document.getElementById(containerId);
        if (!container) continue;
        /** @type {AnimData} */
        var data;
        try {
            data = JSON.parse(/** @type {string} */ (scriptEl.textContent));
        } catch (e) {
            continue;
        }
        if (!data || !data.segments || data.segments.length === 0) continue;

        var state = {
            data: data,
            container: container,
            currentSeg: /** @type {Segment | null} */ (null),
            currentFrame: 0,
            animId: /** @type {number | null} */ (null),
            pauseSteps: data.steps.filter(function (s) {
                return s.pause;
            }),
        };
        animations[containerId] = state;

        // Show first frame
        showFrame(state, 0);

        // Fragment spans are emitted in the HTML at build time (not created dynamically),
        // so Reveal.js sees them during its initial scan. Nothing to create here.

        // Read autoplay setting from the container element
        state.autoPlay = container.getAttribute("data-illuminate-autoplay") === "true";
    }

    /**
     * @param {{animId: number | null}} state
     */
    function stopAnim(state) {
        if (state.animId !== null) {
            cancelAnimationFrame(state.animId);
            state.animId = null;
        }
    }

    /**
     * @param {{data: AnimData, container: HTMLElement, currentSeg: Segment | null, currentFrame: number, animId: number | null}} state
     * @param {number} loopStart
     * @param {number} loopEnd
     */
    function startLoop(state, loopStart, loopEnd) {
        var loopLen = loopEnd - loopStart;
        if (loopLen <= 0) return;
        /** @type {number | null} */
        var startTime = null;
        /** @param {number} timestamp */
        function tick(timestamp) {
            if (startTime === null) startTime = timestamp;
            var frame = animComputeFrame(startTime, timestamp, state.data.fps, loopStart);
            var loop = animWrapLoop(frame, loopStart, loopEnd);
            showFrame(state, loop.wrapped);
            state.animId = requestAnimationFrame(tick);
        }
        state.animId = requestAnimationFrame(tick);
    }

    /**
     * @param {{data: AnimData, container: HTMLElement, currentSeg: Segment | null, currentFrame: number, animId: number | null}} state
     * @param {number} targetFrame
     * @param {(() => void)} [onComplete]
     */
    function animateTo(state, targetFrame, onComplete) {
        stopAnim(state);
        var startFrame = state.currentFrame;
        /** @type {number | null} */
        var startTime = null;
        var dir = targetFrame > startFrame ? 1 : -1;
        /** @param {number} timestamp */
        function tick(timestamp) {
            if (startTime === null) startTime = timestamp;
            var frame = animComputeFrame(startTime, timestamp, state.data.fps, startFrame);
            if (dir < 0) {
                frame = startFrame - (frame - startFrame);
            }
            if ((dir > 0 && frame >= targetFrame) || (dir < 0 && frame <= targetFrame)) {
                showFrame(state, targetFrame);
                state.animId = null;
                if (onComplete) onComplete();
                return;
            }
            showFrame(state, frame);
            state.animId = requestAnimationFrame(tick);
        }
        if (startFrame === targetFrame) {
            if (onComplete) onComplete();
        } else {
            state.animId = requestAnimationFrame(tick);
        }
    }

    /**
     * Syncs an animation to the current fragment state on the slide.
     * When navigating backward, fragments are already visible, so the
     * animation should jump to the corresponding frame.
     * @param {{data: AnimData, container: HTMLElement, currentSeg: Segment | null, currentFrame: number, animId: number | null, pauseSteps: StepInfo[], autoPlay?: boolean}} st
     */
    function syncToFragmentState(st) {
        stopAnim(st);

        // Count how many of this animation's fragments are currently visible
        var parent = st.container.parentElement;
        if (!parent) return;
        var visibleCount = 0;
        var frags = parent.querySelectorAll(
            'span.fragment[data-illuminate-container="' + st.container.id + '"]',
        );
        for (var i = 0; i < frags.length; i++) {
            if (frags[i].classList.contains("visible")) visibleCount++;
        }

        if (visibleCount > 0) {
            // Backward navigation: fragments already shown — jump to end of that step sequence
            var idx = Math.min(visibleCount - 1, st.pauseSteps.length - 1);
            var ps = st.pauseSteps[idx];
            if (ps.loop) {
                var stepIdx = animFindCurrentStep(st.data.steps, ps.frame);
                var stepEnd = animFindStepEnd(st.data.steps, stepIdx, st.data.totalFrames);
                showFrame(st, ps.frame);
                startLoop(st, ps.frame, stepEnd);
            } else {
                showFrame(st, findTargetFrame(st, idx));
            }
        } else if (st.autoPlay) {
            // Forward navigation: auto-play up to (not through) the first pause step
            showFrame(st, 0);
            if (st.pauseSteps.length > 0) {
                animateTo(st, st.pauseSteps[0].frame);
            } else {
                animateTo(st, st.data.totalFrames - 1);
            }
        } else {
            // Forward navigation, no auto-play: show frame 0
            showFrame(st, 0);
        }
    }

    if (typeof Reveal !== "undefined") {
        // Sync animations when entering a slide (handles both forward and backward navigation)
        Reveal.on("slidechanged", function () {
            var slide = Reveal.getCurrentSlide();
            if (!slide) return;
            var containers = slide.querySelectorAll(".illuminate-anim");
            for (var ci = 0; ci < containers.length; ci++) {
                var st = animations[containers[ci].id];
                if (st) syncToFragmentState(st);
            }
        });

        // Also trigger on initial load for the first slide
        Reveal.on("ready", function () {
            var slide = Reveal.getCurrentSlide();
            if (!slide) return;
            var containers = slide.querySelectorAll(".illuminate-anim");
            for (var ci = 0; ci < containers.length; ci++) {
                var st = animations[containers[ci].id];
                if (st) syncToFragmentState(st);
            }
        });

        /**
         * Finds the frame to animate to when pause step `idx` is triggered.
         * Plays through the pause step and any subsequent non-pause steps,
         * stopping at the frame before the next pause step (or at the end).
         */
        function findTargetFrame(state, idx) {
            var nextPauseIdx = idx + 1;
            if (nextPauseIdx < state.pauseSteps.length) {
                // Stop just before the next pause step starts
                return Math.max(
                    state.pauseSteps[nextPauseIdx].frame - 1,
                    state.pauseSteps[idx].frame,
                );
            }
            // Last pause step: play to the end
            return state.data.totalFrames - 1;
        }

        // Helper: process a single animation fragment for fragmentshown
        function handleFragShown(frag) {
            var cid = frag.dataset.illuminateContainer;
            if (!cid) return;
            var state = animations[cid];
            if (!state) return;
            var idx = parseInt(frag.dataset.illuminateStepIndex || "", 10);
            if (isNaN(idx) || idx >= state.pauseSteps.length) return;
            stopAnim(state);
            var ps = state.pauseSteps[idx];
            if (ps.loop) {
                var stepIdx = animFindCurrentStep(state.data.steps, ps.frame);
                var stepEnd = animFindStepEnd(state.data.steps, stepIdx, state.data.totalFrames);
                // Looping step: animate to start, then loop
                animateTo(state, ps.frame, function () {
                    startLoop(state, ps.frame, stepEnd);
                });
            } else {
                // Animate through this step and any following non-pause steps
                var target = findTargetFrame(state, idx);
                animateTo(state, target, function () {
                    // If we landed in a loop step, start looping
                    var finalStepIdx = animFindCurrentStep(state.data.steps, target);
                    var finalStep = state.data.steps[finalStepIdx];
                    if (finalStep && finalStep.loop) {
                        var loopEnd = animFindStepEnd(
                            state.data.steps,
                            finalStepIdx,
                            state.data.totalFrames,
                        );
                        startLoop(state, finalStep.frame, loopEnd);
                    }
                });
            }
        }

        // Helper: process a single animation fragment for fragmenthidden
        function handleFragHidden(frag) {
            var cid = frag.dataset.illuminateContainer;
            if (!cid) return;
            var state = animations[cid];
            if (!state) return;
            var idx = parseInt(frag.dataset.illuminateStepIndex || "", 10);
            if (isNaN(idx)) return;
            stopAnim(state);
            var prevIdx = idx - 1;
            if (prevIdx >= 0) {
                var ps = state.pauseSteps[prevIdx];
                if (ps.loop) {
                    var stepIdx = animFindCurrentStep(state.data.steps, ps.frame);
                    var stepEnd = animFindStepEnd(
                        state.data.steps,
                        stepIdx,
                        state.data.totalFrames,
                    );
                    startLoop(state, ps.frame, stepEnd);
                } else {
                    var target = findTargetFrame(state, prevIdx);
                    animateTo(state, target);
                }
            } else {
                // No previous step — go back to frame 0
                animateTo(state, 0);
            }
        }

        // Reveal.js may fire fragmentshown/hidden with e.fragment (one element)
        // or e.fragments (all elements at that index). Iterate all to find
        // animation fragments when multiple fragments share the same index.
        Reveal.on("fragmentshown", function (e) {
            var frags = e.fragments || [e.fragment];
            for (var fi = 0; fi < frags.length; fi++) {
                handleFragShown(frags[fi]);
            }
        });
        Reveal.on("fragmenthidden", function (e) {
            var frags = e.fragments || [e.fragment];
            for (var fi = 0; fi < frags.length; fi++) {
                handleFragHidden(frags[fi]);
            }
        });
    }
})();
