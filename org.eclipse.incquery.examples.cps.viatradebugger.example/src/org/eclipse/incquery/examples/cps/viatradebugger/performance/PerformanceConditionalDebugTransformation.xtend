package org.eclipse.incquery.examples.cps.viatradebugger.performance

import org.eclipse.incquery.runtime.evm.api.ExecutionSchema
import org.eclipse.viatra.emf.runtime.adapter.impl.AdaptableExecutor
import org.eclipse.viatra.emf.runtime.debug.breakpoints.impl.ConditionalTransformationBreakpoint
import org.eclipse.viatra.emf.runtime.debug.configuration.TransformationDebuggerConfiguration
import org.eclipse.viatra.emf.runtime.transformation.eventdriven.ExecutionSchemaBuilder
import org.eclipse.viatra.emf.runtime.adapter.impl.AdaptableExecutorFactory
import org.eclipse.incquery.examples.cps.viatradebugger.performance.util.PerformanceTestDebuggerUI
import org.eclipse.incquery.examples.cps.viatradebugger.performance.util.BasePerformanceTransformation

class PerformanceConditionalDebugTransformation extends BasePerformanceTransformation{
	extension AdaptableExecutorFactory factory = new AdaptableExecutorFactory();
	
	override ExecutionSchema createExecutionSchema(){
		val debugAdapterConfiguration = new TransformationDebuggerConfiguration(
				new PerformanceTestDebuggerUI(),
                new ConditionalTransformationBreakpoint(engine, queries.getApplicationInstance(engine).specification, 2)
        );
		
		val executor = createAdaptableExecutor()
			.setIncQueryEngine(engine)
			.addConfiguration(debugAdapterConfiguration).build() as AdaptableExecutor
		
		val ExecutionSchemaBuilder builder= new ExecutionSchemaBuilder()
			.setEngine(engine)
			.setExecutor(executor)
			.setConflictResolver(createConflictResolver)

		return builder.build()
	}
}