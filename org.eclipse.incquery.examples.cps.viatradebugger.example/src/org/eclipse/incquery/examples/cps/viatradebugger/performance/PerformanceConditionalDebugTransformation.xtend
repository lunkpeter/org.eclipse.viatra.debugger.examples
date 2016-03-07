package org.eclipse.incquery.examples.cps.viatradebugger.performance

import org.eclipse.incquery.examples.cps.viatradebugger.performance.util.BasePerformanceTransformation
import org.eclipse.incquery.examples.cps.viatradebugger.performance.util.PerformanceTestDebuggerUI
import org.eclipse.viatra.transformation.debug.adapter.impl.AdaptableExecutor
import org.eclipse.viatra.transformation.debug.adapter.impl.AdaptableExecutorFactory
import org.eclipse.viatra.transformation.debug.breakpoints.impl.ConditionalTransformationBreakpoint
import org.eclipse.viatra.transformation.debug.configuration.TransformationDebuggerConfiguration
import org.eclipse.viatra.transformation.evm.api.ExecutionSchema
import org.eclipse.viatra.transformation.runtime.emf.transformation.eventdriven.ExecutionSchemaBuilder

class PerformanceConditionalDebugTransformation extends BasePerformanceTransformation{
	extension AdaptableExecutorFactory factory = new AdaptableExecutorFactory();
	
	override ExecutionSchema createExecutionSchema(){
		val debugAdapterConfiguration = new TransformationDebuggerConfiguration(
				new PerformanceTestDebuggerUI(),
                new ConditionalTransformationBreakpoint(engine, queries.getApplicationInstance(engine).specification, 2)
        );
		
		val executor = createAdaptableExecutor()
			.setQueryEngine(engine)
			.addConfiguration(debugAdapterConfiguration).build() as AdaptableExecutor
		
		val ExecutionSchemaBuilder builder= new ExecutionSchemaBuilder()
			.setEngine(engine)
			.setExecutor(executor)
			.setConflictResolver(createConflictResolver)

		return builder.build()
	}
}