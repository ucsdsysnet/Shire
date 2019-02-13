#!/usr/bin/env python
"""

Copyright (c) 2018 Alex Forencich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

"""

from myhdl import *
import os

import axis_ep
import eth_ep
import xgmii_ep

testbench = 'test_riscv_eth'

srcs = []

srcs.append("../rtl/eth_interface.v")
srcs.append("../rtl/core_mems.v")
srcs.append("../rtl/VexRiscv.v")
srcs.append("../rtl/riscvcore.v")
srcs.append("../rtl/riscv_axi_wrapper.v")
srcs.append("../lib/axi/rtl/axi_dma.v")
srcs.append("../lib/axi/rtl/axi_dma_rd.v")
srcs.append("../lib/axi/rtl/axi_dma_wr.v")
srcs.append("../lib/axi/rtl/axi_ram_rd_if.v")
srcs.append("../lib/axi/rtl/axi_ram_wr_if.v")
srcs.append("../lib/axis/rtl/axis_async_fifo.v")
srcs.append("../lib/axis/rtl/axis_adapter.v")
srcs.append("../lib/eth/rtl/eth_mac_10g.v")
srcs.append("../lib/eth/rtl/lfsr.v")
srcs.append("../lib/eth/rtl/axis_xgmii_rx_64.v")
srcs.append("../lib/eth/rtl/axis_xgmii_tx_64.v")

srcs.append("%s.v" % testbench)

src = ' '.join(srcs)

build_cmd = "iverilog -o %s.vvp %s" % (testbench, src)

def bench():

    # Parameters
    DATA_WIDTH = 64
    CTRL_WIDTH = (DATA_WIDTH/8)
    AXI_DATA_WIDTH = 64
    AXI_ADDR_WIDTH = 16
    AXI_STRB_WIDTH = (AXI_DATA_WIDTH/8)
    AXI_ID_WIDTH = 8
    AXI_MAX_BURST_LEN = 16
    AXIS_DATA_WIDTH = AXI_DATA_WIDTH
    AXIS_KEEP_ENABLE = (AXIS_DATA_WIDTH>8)
    AXIS_KEEP_WIDTH = (AXIS_DATA_WIDTH/8)
    AXIS_ID_ENABLE = 1
    AXIS_ID_WIDTH = 8
    AXIS_DEST_ENABLE = 0
    AXIS_DEST_WIDTH = 8
    AXIS_USER_ENABLE = 1
    AXIS_USER_WIDTH = 1
    LEN_WIDTH = 20
    TAG_WIDTH = 8
    ENABLE_SG = 0
    ENABLE_UNALIGNED = 1
    IMEM_SIZE_BYTES = 8192
    DMEM_SIZE_BYTES = 32768
    INTERLEAVE      = 1
    PIPELINE_OUTPUT = 0
    STAT_ADDR_WIDTH = 1
    ENABLE_PADDING = 1
    ENABLE_DIC = 1
    MIN_FRAME_LENGTH = 64
    TX_FRAME_FIFO = 1
    TX_DROP_WHEN_FULL = 0
    RX_FRAME_FIFO = 1

    # Inputs
    clk = Signal(bool(0))
    rst = Signal(bool(0))
    tx_clk = Signal(bool(0))
    tx_rst = Signal(bool(0))
    rx_clk = Signal(bool(0))
    rx_rst = Signal(bool(0))
    current_test = Signal(intbv(0)[8:])

    s_axis_tx_desc_addr = Signal(intbv(0)[AXI_ADDR_WIDTH:])
    s_axis_tx_desc_len = Signal(intbv(0)[LEN_WIDTH:])
    s_axis_tx_desc_tag = Signal(intbv(0)[TAG_WIDTH:])
    s_axis_tx_desc_id = Signal(intbv(0)[AXIS_ID_WIDTH:])
    s_axis_tx_desc_dest = Signal(intbv(0)[AXIS_DEST_WIDTH:])
    s_axis_tx_desc_user = Signal(intbv(0)[AXIS_USER_WIDTH:])
    s_axis_tx_desc_valid = Signal(bool(0))
    s_axis_rx_desc_addr = Signal(intbv(0)[AXI_ADDR_WIDTH:])
    s_axis_rx_desc_len = Signal(intbv(0)[LEN_WIDTH:])
    s_axis_rx_desc_tag = Signal(intbv(0)[TAG_WIDTH:])
    s_axis_rx_desc_valid = Signal(bool(0))
    tx_enable = Signal(bool(0))
    rx_enable = Signal(bool(0))
    rx_abort = Signal(bool(0))
    
    xgmii_rxd = Signal(intbv(0x0707070707070707)[DATA_WIDTH:])
    xgmii_rxc = Signal(intbv(0xff)[CTRL_WIDTH:])
    ifg_delay = Signal(intbv(0)[8:])

    # Outputs
    s_axis_tx_desc_ready = Signal(bool(0))
    m_axis_tx_desc_status_tag = Signal(intbv(0)[TAG_WIDTH:])
    m_axis_tx_desc_status_valid = Signal(bool(0))
    s_axis_rx_desc_ready = Signal(bool(0))
    m_axis_rx_desc_status_len = Signal(intbv(0)[LEN_WIDTH:])
    m_axis_rx_desc_status_tag = Signal(intbv(0)[TAG_WIDTH:])
    m_axis_rx_desc_status_id = Signal(intbv(0)[AXIS_ID_WIDTH:])
    m_axis_rx_desc_status_dest = Signal(intbv(0)[AXIS_DEST_WIDTH:])
    m_axis_rx_desc_status_user = Signal(intbv(0)[AXIS_USER_WIDTH:])
    m_axis_rx_desc_status_valid = Signal(bool(0))
    
    xgmii_txd = Signal(intbv(0x0707070707070707)[DATA_WIDTH:])
    xgmii_txc = Signal(intbv(0xff)[CTRL_WIDTH:])
    rx_error_bad_frame = Signal(bool(0))
    rx_error_bad_fcs = Signal(bool(0))
    tx_fifo_overflow   = Signal(bool(0))
    tx_fifo_bad_frame  = Signal(bool(0))
    tx_fifo_good_frame = Signal(bool(0))
    rx_fifo_overflow   = Signal(bool(0))
    rx_fifo_bad_frame  = Signal(bool(0))
    rx_fifo_good_frame = Signal(bool(0))
    
    status_update = Signal(bool(0))
    
    # sources and sinks
    xgmii_source = xgmii_ep.XGMIISource()

    xgmii_source_logic = xgmii_source.create_logic(
        clk,
        rst,
        txd=xgmii_rxd,
        txc=xgmii_rxc,
        name='xgmii_source'
    )

    xgmii_sink = xgmii_ep.XGMIISink()

    xgmii_sink_logic = xgmii_sink.create_logic(
        clk,
        rst,
        rxd=xgmii_txd,
        rxc=xgmii_txc,
        name='xgmii_sink'
    )

    read_desc_source = axis_ep.AXIStreamSource()
    read_desc_source_pause = Signal(bool(False))

    read_desc_source_logic = read_desc_source.create_logic(
        clk,
        rst,
        tdata=(s_axis_tx_desc_addr, s_axis_tx_desc_len, s_axis_tx_desc_tag, s_axis_tx_desc_id, s_axis_tx_desc_dest, s_axis_tx_desc_user),
        tvalid=s_axis_tx_desc_valid,
        tready=s_axis_tx_desc_ready,
        pause=read_desc_source_pause,
        name='read_desc_source'
    )

    read_desc_status_sink = axis_ep.AXIStreamSink()

    read_desc_status_sink_logic = read_desc_status_sink.create_logic(
        clk,
        rst,
        tdata=(m_axis_tx_desc_status_tag,),
        tvalid=m_axis_tx_desc_status_valid,
        name='read_desc_status_sink'
    )

    write_desc_source = axis_ep.AXIStreamSource()
    write_desc_source_pause = Signal(bool(False))

    write_desc_source_logic = write_desc_source.create_logic(
        clk,
        rst,
        tdata=(s_axis_rx_desc_addr, s_axis_rx_desc_len, s_axis_rx_desc_tag),
        tvalid=s_axis_rx_desc_valid,
        tready=s_axis_rx_desc_ready,
        pause=write_desc_source_pause,
        name='write_desc_source'
    )

    write_desc_status_sink = axis_ep.AXIStreamSink()

    write_desc_status_sink_logic = write_desc_status_sink.create_logic(
        clk,
        rst,
        tdata=(m_axis_rx_desc_status_len, m_axis_rx_desc_status_tag, m_axis_rx_desc_status_id, m_axis_rx_desc_status_dest, m_axis_rx_desc_status_user),
        tvalid=m_axis_rx_desc_status_valid,
        name='write_desc_status_sink'
    )

    # DUT
    if os.system(build_cmd):
        raise Exception("Error running build command")

    dut = Cosimulation(
        "vvp -m myhdl %s.vvp -lxt2" % testbench,
        logic_clk=clk,
        logic_rst=rst,
        rx_clk=rx_clk,
        rx_rst=rx_rst,
        tx_clk=tx_clk,
        tx_rst=tx_rst,
        current_test=current_test,
        s_axis_tx_desc_addr=s_axis_tx_desc_addr,
        s_axis_tx_desc_len=s_axis_tx_desc_len,
        s_axis_tx_desc_tag=s_axis_tx_desc_tag,
        s_axis_tx_desc_user=s_axis_tx_desc_user,
        s_axis_tx_desc_valid=s_axis_tx_desc_valid,
        s_axis_tx_desc_ready=s_axis_tx_desc_ready,
        m_axis_tx_desc_status_tag=m_axis_tx_desc_status_tag,
        m_axis_tx_desc_status_valid=m_axis_tx_desc_status_valid,
        s_axis_rx_desc_addr=s_axis_rx_desc_addr,
        s_axis_rx_desc_len=s_axis_rx_desc_len,
        s_axis_rx_desc_tag=s_axis_rx_desc_tag,
        s_axis_rx_desc_valid=s_axis_rx_desc_valid,
        s_axis_rx_desc_ready=s_axis_rx_desc_ready,
        m_axis_rx_desc_status_len=m_axis_rx_desc_status_len,
        m_axis_rx_desc_status_tag=m_axis_rx_desc_status_tag,
        m_axis_rx_desc_status_user=m_axis_rx_desc_status_user,
        m_axis_rx_desc_status_valid=m_axis_rx_desc_status_valid,
        tx_enable=tx_enable,
        rx_enable=rx_enable,
        rx_abort=rx_abort,
        xgmii_rxd=xgmii_rxd,
        xgmii_rxc=xgmii_rxc,
        xgmii_txd=xgmii_txd,
        xgmii_txc=xgmii_txc,
        rx_error_bad_frame=rx_error_bad_frame,
        rx_error_bad_fcs=rx_error_bad_fcs,
        tx_fifo_overflow=tx_fifo_overflow,
        tx_fifo_bad_frame=tx_fifo_bad_frame,
        tx_fifo_good_frame=tx_fifo_good_frame,
        rx_fifo_overflow=rx_fifo_overflow,
        rx_fifo_bad_frame=rx_fifo_bad_frame,
        rx_fifo_good_frame=rx_fifo_good_frame,
        ifg_delay=ifg_delay,
        status_update=status_update
    )

    @always(delay(4))
    def clkgen():
        clk.next = not clk
        tx_clk.next = not tx_clk
        rx_clk.next = not rx_clk

    @instance
    def check():
        yield delay(100)
        yield clk.posedge
        tx_rst.next = 1
        rx_rst.next = 1
        rst.next = 1
        yield clk.posedge
        tx_rst.next = 0
        rx_rst.next = 0
        rst.next = 0
        yield clk.posedge
        yield delay(100)
        yield clk.posedge
        
        ifg_delay.next = 12

        # testbench stimulus

        cur_tag = 1

        rx_enable.next = 1
        tx_enable.next = 1

        yield clk.posedge
        print("test 1: single data")
        current_test.next = 1

        addr = 0x00000000
        test_data = b'\x11\x22\x33\x44\x11\x22\x33\x44'

        test_frame = eth_ep.EthFrame()
        test_frame.eth_dest_mac = 0xDAD1D2D3D4D5
        test_frame.eth_src_mac = 0x5A5152535455
        test_frame.eth_type = 0x8000
        test_frame.payload = test_data # bytearray(range(32))
        test_frame.update_fcs()
        axis_frame = test_frame.build_axis_fcs()
        
        write_desc_source.send([(addr, len(axis_frame.data)+8, cur_tag)])
        # yield write_desc_status_sink.wait(2000)

        yield delay(1000)

        xgmii_source.send(b'\x55\x55\x55\x55\x55\x55\x55\xD5'+bytearray(axis_frame))
        yield clk.posedge
        yield delay(1000)

        read_desc_source.send([(addr, len(axis_frame.data)+8, cur_tag, cur_tag, 0, 0)])
        # yield read_desc_status_sink.wait(1000)
        yield delay(1000)
        status = read_desc_status_sink.recv()
        print(status)
        
        yield xgmii_sink.wait()
        rx_frame = xgmii_sink.recv()
       
        assert rx_frame.data[0:8] == bytearray(b'\x55\x55\x55\x55\x55\x55\x55\xD5')
        data = rx_frame.data
        for i in range(0, len(data), 16):
            print(" ".join(("{:02x}".format(c) for c in bytearray(data[i:i+16]))))
        eth_frame = eth_ep.EthFrame()
        eth_frame.parse_axis_fcs(rx_frame.data[8:])

        print(hex(eth_frame.eth_fcs))
        print(hex(eth_frame.calc_fcs()))

        assert len(eth_frame.payload.data) == 46
        assert eth_frame.eth_fcs == eth_frame.calc_fcs()
        assert eth_frame.eth_dest_mac == test_frame.eth_dest_mac
        assert eth_frame.eth_src_mac == test_frame.eth_src_mac
        assert eth_frame.eth_type == test_frame.eth_type
        assert eth_frame.payload.data.index(test_frame.payload.data) == 0

        yield delay(1000)
        yield clk.posedge

        # print ("loading instruction memory")
        # cur_tag = (cur_tag + 1) % 256
        # test_data = bytearray(open("../../c_code/test.bin", "rb").read())
        # write_desc_source.send([(0x8000, len(test_data), cur_tag)])
        # write_data_source.send(axis_ep.AXIStreamFrame(test_data, id=cur_tag))
        # yield write_desc_status_sink.wait(2000)
        # yield delay(1000)
        # yield clk.posedge
        
        # print ("loading initial data")
        # cur_tag = (cur_tag + 1) % 256
        # a = 400*[0]
        # for i in range (0,400,4):
        #     a[i+3] = (i>>2)
        # test_data = bytes(a)
        # write_desc_source.send([(0x800, len(test_data), cur_tag)])
        # write_data_source.send(axis_ep.AXIStreamFrame(test_data, id=cur_tag))
        # yield write_desc_status_sink.wait(2000)
        # yield delay(1000)
        # yield clk.posedge
        # 
        # print ("core reset")
        # cur_tag = (cur_tag + 1) % 256
        # # core reset
        # yield delay(100)
        # yield clk.posedge
        # test_data = b'\x00'
        # write_desc_source.send([(0xffff, len(test_data), cur_tag)])
        # write_data_source.send(axis_ep.AXIStreamFrame(test_data, id=cur_tag))
        # yield write_desc_status_sink.wait(2000)
        # yield delay(1000)
        # yield clk.posedge

        # print ("running the core") 
        # cycles = 0
        # while (1):
        #     while (status_update == 0) and (cycles < 2500):
        #         yield clk.posedge
        #         cycles+=1
        #     cur_tag = (cur_tag + 1) % 256
        #     read_desc_source.send([(0x8000, 4, cur_tag, cur_tag, 0, 0)])
        #     yield read_desc_status_sink.wait(1000)
        #     yield read_data_sink.wait(1000)
        #     status = read_desc_status_sink.recv()
        #     read_data = read_data_sink.recv()
        #     yield clk.posedge
        #     print(read_data.data)
        #     if cycles >= 2500:
        #         break
        # 
        # yield clk.posedge
        # cur_tag = (cur_tag + 1) % 256
        # read_desc_source.send([(0x1000, 400, cur_tag, cur_tag, 0, 0)])
        # yield read_desc_status_sink.wait(1000)
        # yield read_data_sink.wait(1000)
        # status = read_desc_status_sink.recv()
        # read_data = read_data_sink.recv()
        # yield clk.posedge
        # data = read_data.data
        # for i in range(0, len(data), 16):
        #     print(" ".join(("{:02x}".format(c) for c in bytearray(data[i:i+16]))))

        yield delay(100)

        yield clk.posedge

        raise StopSimulation

    return instances()

def test_bench():
    sim = Simulation(bench())
    sim.run()

if __name__ == '__main__':
    print("Running test...")
    test_bench()
