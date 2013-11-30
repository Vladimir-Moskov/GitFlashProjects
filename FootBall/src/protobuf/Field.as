package  protobuf{
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;

	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class Field extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const PLAYERS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("Field.players", "players", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return Player; });

		[ArrayElementType("Player")]
		public var players:Array = [];

		/**
		 *  @private
		 */
		public static const BALL:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("Field.ball", "ball", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return Ball; });

		public var ball:Ball;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			for (var players$index:uint = 0; players$index < this.players.length; ++players$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.players[players$index]);
			}
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.ball);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var ball$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					this.players.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new Player()));
					break;
				case 2:
					if (ball$count != 0) {
						throw new flash.errors.IOError('Bad data format: Field.ball cannot be set twice.');
					}
					++ball$count;
					this.ball = new Ball();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.ball);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
