package org.eclipse.incquery.examples.cps.viatradebugger

import org.eclipse.incquery.examples.cps.viatradebugger.example.ViatraTransformation
import org.eclipse.viatra.transformation.debug.adapter.impl.AdaptableExecutorFactory
import org.eclipse.viatra.transformation.debug.breakpoints.impl.ConditionalTransformationBreakpoint
import org.eclipse.viatra.transformation.debug.configuration.TransformationDebuggerConfiguration
import org.junit.Test
import org.eclipse.incquery.examples.cps.viatradebugger.example.CPSModelInitializer

class RunCondDebuggerTransformation {
	extension AdaptableExecutorFactory factory = new AdaptableExecutorFactory();
	extension ViatraTransformation transformation

	@Test def void runViatraConditionalDebugTransformation() {
		val init = new CPSModelInitializer()
		val cps2dep = init.loadModel("output/example.cyberphysicalsystem")
		
		transformation = new ViatraTransformation(cps2dep)
		
		val debugAdapterConfiguration = new TransformationDebuggerConfiguration(
			new ConditionalTransformationBreakpoint(engine, queries.getApplicationInstance(engine).specification, 2))
			
		val executor = createAdaptableExecutor().setQueryEngine(engine).addConfiguration(
			debugAdapterConfiguration).build()
			
		transformation.setExecutor(executor).initialize()
		transformation.execute
		
	}

}
