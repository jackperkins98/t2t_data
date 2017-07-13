PROBLEM=sequence_tagger_tokens_8k
MODEL=transformer
HPARAMS=transformer_base

DATA_DIR=$HOME/t2t_data
TMP_DIR=/tmp/t2t_datagen
TRAIN_DIR=$HOME/t2t_train/$PROBLEM/$MODEL-$HPARAMS

mkdir -p $DATA_DIR $TMP_DIR $TRAIN_DIR

# Generate data
t2t-datagen \
  --data_dir=$DATA_DIR \
  --tmp_dir=$TMP_DIR \
  --num_shards=100 \
  --problem=$PROBLEM

#*********** REMOVE IF NOT DOING TOKEN-BASED PROBLEM ***********
cp $TMP_DIR/tokens.vocab.* $DATA_DIR

# Train
# *  If you run out of memory, add --hparams='batch_size=2048' or even 1024.
t2t-trainer \
  --data_dir=$DATA_DIR \
  --problems=$PROBLEM \
  --model=$MODEL \
  --hparams_set=$HPARAMS \
  --output_dir=$TRAIN_DIR
